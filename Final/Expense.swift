//
//  Expense.swift
//  Final
//
//  Created by Wade Belden on 5/8/21.
//

import Foundation

class Expenses: ObservableObject {
    
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "ExpenseItems")
            }
        }
    }
        init() {
            if let items = UserDefaults.standard.data(forKey: "ExpenseItems") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                    self.items = decoded
                    return
                }
            }
            self.items = []
    }
}

struct ExpenseItem : Codable, Identifiable {
    static let categories = ["Travel", "Food", "Materials", "Tools"]
    let id: Int
    let name: String
    let amount: Double
    let category: Int
}
