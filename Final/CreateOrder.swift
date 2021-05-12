//
//  CreateOrder.swift
//  Final
//
//  Created by Wade Belden on 5/5/21.
//

import SwiftUI

struct CreateOrder: View {
    @ObservedObject var orders: Orders
    @Environment(\.presentationMode) var presentationMode
    @State private var id = ""
    @State private var name = ""
    @State private var phone = ""
    @State private var price = ""
    @State private var description = ""
    @State private var due = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                Form {
                    TextField("Order number", text: $id)
                        .keyboardType(.numberPad)
                    TextField("Customer name", text: $name)
                    TextField("Customer phone", text: $phone)
                        .keyboardType(.numberPad)
                    TextField("Quoted Price", text: $price)
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Work Description", text: $description)
                        .frame(height: geo.size.height / 7)
                    TextField("Order Due", text: $due)
                        .keyboardType(.numberPad)                }
            }
            .navigationBarTitle("Create Order", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                
                
                
                if let testID = Int(self.id), let testPrice = Double(self.price) {
                    let item = OrderItem(id: testID, name: self.name, phone: self.phone, price: testPrice, description: self.description, due: self.due)
                    self.orders.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                
                } else {
                    print(Text("error initializing object"))
                    //create an alert for input errors
                }
                
            })
        
        .padding(5)
        }
    }
}

struct CreateOrder_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrder(orders: Orders())
    }
}
