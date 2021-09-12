//
//  ContentView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
//            BusinessListView(businessListViewModel: BusinessListViewModel())
//            NewBusinessForm(businessListViewModel: BusinessListViewModel())
            NewBusinessForm(menu: typeList, businessListViewModel: BusinessListViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
