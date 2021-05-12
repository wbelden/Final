//
//  CreateExpense.swift
//  Final
//
//  Created by Wade Belden on 5/10/21.
//

import SwiftUI

struct CreateExpense: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var id = ""
    @State private var name = ""
    @State private var amount = ""
    @State private var category = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                Form {
                    TextField("Expense number", text: $id)
                        .keyboardType(.numberPad)
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                        .keyboardType(.numbersAndPunctuation)
                    Picker("Select the expense category", selection: $category) {
                        ForEach(0..<ExpenseItem.categories.count, id: \.self){
                            Text(ExpenseItem.categories[$0])
                        }
                    }
                }
            }
            .navigationBarTitle("Create Expense", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                
                
                
                if let testID = Int(self.id), let testAmount = Double(self.amount) {
                    let item = ExpenseItem(id: testID, name: self.name, amount: testAmount, category: self.category)
                    self.expenses.items.append(item)
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

struct CreateExpense_Previews: PreviewProvider {
    static var previews: some View {
        CreateExpense(expenses: Expenses())
    }
}
