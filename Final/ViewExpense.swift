//
//  ViewExpense.swift
//  Final
//
//  Created by Wade Belden on 5/10/21.
//

import SwiftUI

struct ViewExpense: View {
    @ObservedObject var expenses = Expenses()
    @State private var selectionItem = ExpenseItem(id: 0, name: "", amount: 0, category: 0)
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        List{
                            ForEach(expenses.items, id: \.id) { item in
                                Text("Expense #\(item.id): \(item.name)")
                                .onTapGesture {
                                    self.selectionItem = item
                                }
                                    .listRowBackground(self.selectionItem.id == item.id ? Color.blue : Color.white)
                            }
                        }
                    }
                    
                    Section {
                        Text("Expense #:                          \(selectionItem.id)")
                        Text("Name:                  \(selectionItem.name)")
                        Text("Amount:                   \(selectionItem.amount)")
                        Text("Expense category:         \(selectionItem.category)")
                    }
                    
                }
            
            }
            .navigationBarTitle("View Expense", displayMode: .inline)
            .padding(5)
        }
    }
}

struct ViewExpense_Previews: PreviewProvider {
    static var previews: some View {
        ViewExpense()
    }
}
