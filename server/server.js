// Replace if using a different env file or config
require("dotenv").config({ path: "./.env" });
const express = require("express");
const app = express();
const { resolve } = require("path");
const bodyParser = require("body-parser");
const stripe = require("stripe")(process.env.STRIPE_SECRET_KEY);
const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
app.use(express.static(process.env.STATIC_DIR));

// Firebase
const admin = require('firebase-admin');
var serviceAccount = require("./yakden-orderahead-firebase-adminsdk-675fh-98c4814e6c.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
const db = admin.firestore();

// Use JSON parser for all non-webhook routes
app.use((req, res, next) => {
  if (req.originalUrl === "/webhook") {
    next();
  } else {
    bodyParser.json()(req, res, next);
  }
});

app.post('/create-payment-intent', async (req, res) => {
    const {paymentMethodType, currency, connectedAccID} = req.body;
    // const {paymentMethodType, currency, companyAccID} = req.body;
    try {
        const paymentIntent = await stripe.paymentIntents.create({
            'amount': 1999,
            'currency': currency,
            'payment_method_types[]': paymentMethodType,
            'on_behalf_of': connectedAccID,
            'transfer_data': {
                'destination': connectedAccID
            },
        });
        // const paymentIntent = await stripe.paymentIntents.create({
        //     'amount': 1999,
        //     'currency': currency,
        //     'payment_method_types[]': paymentMethodType,
        //     'on_behalf_of': companyAccID,
        //     'transfer_data': {
        //         'destination': companyAccID,
        //     },
        // });
        res.json({ clientSecret: paymentIntent.client_secret });
    } catch(e) {
        console.log(e);
        res.status(400).json({ error: { message: e.message }});
    }
});

app.post('/create-express-account', async (req, res) => {
    const {firestoreID} = req.body

    const account = await stripe.accounts.create({
        country: 'US',
        type: 'custom',
        capabilities: {
            card_payments: {
                requested: true,
            },
            transfers: {
                requested: true,
            },
        },
    });

    console.log(`Created account ${account.id}`);

    const accountLinks = await stripe.accountLinks.create({
      account: account.id,
      refresh_url: 'http://localhost:4242/create-express-account',
      return_url: 'http://localhost:8008/',
      type: 'account_onboarding',
    });

    console.log(`🔗 Account linked`);

    // Add account ID to firestore document
    console.log(firestoreID)
    console.log(req.body)
    const docref = db.collection('businesses').doc(firestoreID);
    await docref.update({
      'stripeaccountid': account.id
    });

    // console.log(`📝 Recorded stripe id: ${firestoreID}`);

    // res.status(301).redirect(accountLinks.url);
    console.log(accountLinks.url)
    res.json({url: accountLinks.url})
});

express().use(function (req, res) {
  res.status(302)
  res.header('Server', 'Apache/2.4.23 (Win64) PHP/5.6.25')
  res.header('Location', 'orderahead://')
  res.header('Content-Type', 'text/html; charset=iso-8859-1')
  res.end()
}).listen(8008)

app.get('/delete-restricted-express-accounts', async (req, res) => {
    // TODO: Make this a post request with a user id / password
    // Cross check that login with firebase to see if they're admin
    // If not an admin return
    const accounts = await stripe.accounts.list({
      limit: 100,
    });
    console.log(`Accounts: ${accounts.data}`);
    await Promise.all(accounts.data.map(async (acc) => {
        // console.log(`Status: ${acc.status}`);
        console.log(`Deleting account ${acc.id}`);
        const response = await stripe.oauth.deauthorize({
          client_id: 'ca_KB9wl0OKjdVGJ7cScLD31n0TLAwkFXki',
          stripe_user_id: acc.id,
      });
    }));
});

app.get('/config', async (req, res) => {
    res.json({publishableKey: process.env.STRIPE_PUBLISHABLE_KEY});
});

app.get("/", (req, res) => {
  const path = resolve(process.env.STATIC_DIR + "/index.html");
  res.sendFile(path);
});

// Stripe requires the raw body to construct the event
app.post(
  "/webhook",
  bodyParser.raw({ type: "application/json" }),
  (req, res) => {
    const sig = req.headers["stripe-signature"];

    let event;

    try {
      event = stripe.webhooks.constructEvent(req.body, sig, webhookSecret);
    } catch (err) {
      // On error, log and return the error message
      console.log(`❌ Error message: ${err.message}`);
      return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    const paymentIntent = event.data.object;

    switch(event.type) {
        case 'payment_intent.created':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        case 'payment_intent.canceled':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        case 'payment_intent.payment_failed':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        case 'payment_intent.processing':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        case 'payment_intent.requires_action':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        case 'payment_intent.succeeded':
            console.log(`💸 [${event.id}] PaymentIntent created! (${paymentIntent.id}): ${paymentIntent.status}`);
            break;
        default:
            console.log(`❌ Event type ${event.type} not handed on Node JS backend`);
    }

    // Successfully constructed event
    // console.log("✅ Success:", event.id);

    // Return a response to acknowledge receipt of the event
    res.json({ received: true });
  }
);

app.listen(4242, () => console.log(`Node server listening on port ${4242}!`));
