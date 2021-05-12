//
//  ViewOrders.swift
//  Final
//
//  Created by Wade Belden on 5/5/21.
//

import SwiftUI

struct ViewOrders: View {
    @ObservedObject var orders = Orders()
    @State private var selectionItem = OrderItem(id: 0, name: "", phone: "", price: 0, description: "", due: "")
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        List{
                            ForEach(orders.items, id: \.id) { item in
                                Text("Order #\(item.id): \(item.name)")
                                .onTapGesture {
                                    self.selectionItem = item
                                }
                                    .listRowBackground(self.selectionItem.id == item.id ? Color.blue : Color.white)
                            }
                        }
                    }
                    
                    Section {
                        Text("Quote Only")
                        Text("Invoice Sent")
                        Text("Payment Received")
                    }
                    
                    Section {
                        Text("Order #:                          \(selectionItem.id)")
                        Text("Client Name:                  \(selectionItem.name)")
                        Text("Client Phone:                 \(selectionItem.phone)")
                        Text("Quote Price:                   \(selectionItem.price)")
                        Text("Work Description:         \(selectionItem.description)")
                            .frame(height: 75)
                        Text("Order Due Date:            \(selectionItem.due)")
                    }
                    
                }
            
            }
            .navigationBarTitle("View Order", displayMode: .inline)
            .padding(5)
        }
    }
}

struct ViewOrders_Previews: PreviewProvider {
    static var previews: some View {
        ViewOrders(orders: Orders())
    }
}
