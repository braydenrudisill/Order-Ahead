const functions = require("firebase-functions");

const admin = require('firebase-admin');
admin.initializeApp();

// Set your secret key. Remember to switch to your live secret key in production.
// See your keys here: https://dashboard.stripe.com/apikeys
const stripe = require('stripe')('sk_test_51J3O5IKIZgLeu6ZO8n1uoo2utkbTo4FWGZz5Svt0Kb4aP4bwy4GgyV0ORT5C7JeuHayKBNp2BfZXok1MVUelk1oI00TdPsPjsh');

exports.getStripeSecretKey =  functions.https.onCall((data, context) => {
    return {
        stripesecretkeys: functionConfig().stripesecretkeys.key
    };
})

// In a new endpoint on your server, create a ConnectionToken and return the
// `secret` to your app. The SDK needs the `secret` to connect to a reader.
let connectionToken = stripe.terminal.connectionTokens.create();

const express = require('express');
const app = express();

app.post('/connection_token', async (req, res) => {
  const token = // ... Fetch or create the ConnectionToken
  res.json({secret: token.secret});
});

app.listen(3000, () => {
  console.log('Running on port 3000');
});

// // Take the text parameter passed to this HTTP endpoint and insert it into
// // Firestore under the path /messages/:documentId/original
// exports.addMessage = functions.https.onRequest(async (req, res) => {
//   // Grab the text parameter.
//   const original = req.query.text;
//   // Push the new message into Firestore using the Firebase Admin SDK.
//   const writeResult = await admin.firestore().collection('messages').add({original: original});
//   // Send back a message that we've successfully written the message
//   res.json({result: `Message with ID: ${writeResult.id} added.`});
// });
//
// // Listens for new messages added to /messages/:documentId/original and creates an
// // uppercase version of the message to /messages/:documentId/uppercase
// exports.makeUppercase = functions.firestore.document('/messages/{documentId}')
//     .onCreate((snap, context) => {
//       // Grab the current value of what was written to Firestore.
//       const original = snap.data().original;
//
//       // Access the parameter `{documentId}` with `context.params`
//       functions.logger.log('Uppercasing', context.params.documentId, original);
//
//       const uppercase = original.toUpperCase();
//
//       // You must return a Promise when performing asynchronous tasks inside a Functions such as
//       // writing to Firestore.
//       // Setting an 'uppercase' field in Firestore document returns a Promise.
//       return snap.ref.set({uppercase}, {merge: true});
//     });
