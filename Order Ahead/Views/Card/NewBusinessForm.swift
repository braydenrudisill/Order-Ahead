// Copyright (c) 2020 Razeware LLC

import SwiftUI

struct NewBusinessForm: View {
  @State var question: String = ""
  @State var answer: String = ""
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var businessListViewModel: BusinessListViewModel

  var body: some View {
    VStack(alignment: .center, spacing: 30) {
      VStack(alignment: .leading, spacing: 10) {
        Text("Question")
          .foregroundColor(.gray)
        TextField("Enter the question", text: $question)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      VStack(alignment: .leading, spacing: 10) {
        Text("Answer")
          .foregroundColor(.gray)
        TextField("Enter the answer", text: $answer)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }

      Button(action: addBusiness) {
        Text("Add New Business")
          .foregroundColor(.blue)
      }
      Spacer()
    }
    .padding(EdgeInsets(top: 80, leading: 40, bottom: 0, trailing: 40))
  }

  private func addBusiness() {
    let business = Business(question: question, answer: answer)
    businessListViewModel.add(business)
    presentationMode.wrappedValue.dismiss()
  }
}

struct NewBusinessForm_Previews: PreviewProvider {
  static var previews: some View {
    NewBusinessForm(businessListViewModel: BusinessListViewModel())
  }
}
