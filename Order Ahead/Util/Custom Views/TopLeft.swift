   
   //
   //  VTabView.swift
   //  Order Ahead
   //
   //  Created by Brayden Rudisill on 8/30/21.
   //

import SwiftUI

// View Builder
struct TopLeft<Content: View>: View {
   let content: Content
   
   init(@ViewBuilder content: () -> Content) {
       self.content = content()
   }
   
   var body: some View {
    HStack() {
        VStack(alignment: .leading) {
            content
            Spacer()
        }
        Spacer()
    }
   }
}


