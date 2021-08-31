//
//  TypeListView.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import SwiftUI

struct TypeListView: View {
    
    var body: some View {
//        HStack {
//            VStack {
//                ForEach(0 ..< typeList.count) { i in
//                    if(i%2==0) {TypeCard(itemlist: typeList[i])}
//                }
//            }
//            VStack {
//                ForEach(0 ..< typeList.count) { i in
//                    if(i%2==1) {TypeCard(itemlist: typeList[i])}
//                }
//            }
//        }
        VStack(spacing: 7) {
            ForEach(0 ..< typeList.count/2) { i in
                HStack(spacing: 7) {
                    
                    TypeCard(itemlist: typeList[2*i])
                    TypeCard(itemlist: typeList[2*i+1])
                }
            }
            if(typeList.count%2==1) {
                TypeCard(itemlist: typeList[typeList.count-1])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TypeListView()
    }
}
