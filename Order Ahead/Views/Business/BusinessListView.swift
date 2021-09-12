// Copyright (c) 2020 Razeware LLC

import SwiftUI

struct BusinessListView: View {
  @ObservedObject var businessListViewModel = BusinessListViewModel()
  @State var showForm = false

  var body: some View {
      VStack {
        Spacer()
        VStack {
          GeometryReader { geometry in
            ScrollView(.horizontal) {
              HStack(spacing: 10) {
                ForEach(businessListViewModel.businessViewModels) { businessViewModel in
                  BusinessView(businessViewModel: businessViewModel)
                    .padding([.leading, .trailing])
                }
              }.frame(height: geometry.size.height)
            }
          }
        }
        Spacer()
      }
      .sheet(isPresented: $showForm) {
        NewBusinessForm(menu: typeList, businessListViewModel: BusinessListViewModel())
      }
//      .navigationBarTitle("Fire Business")
      // swiftlint:disable multiple_closures_with_trailing_closure
//        .navigationBarItems(trailing: Button(action: { showForm.toggle() }) {
//          Image(systemName: "plus")
//            .font(.title)
//        })
  }
}

struct BusinessListView_Previews: PreviewProvider {
  static var previews: some View {
    BusinessListView(businessListViewModel: BusinessListViewModel())
  }
}
