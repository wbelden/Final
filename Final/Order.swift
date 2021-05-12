//
//  Order.swift
//  Final
//
//  Created by Wade Belden on 5/7/21.
//

import Foundation

class Orders: ObservableObject {
    @Published var items = [OrderItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "OrderItems")
            }
        }
    }
        init() {
            if let items = UserDefaults.standard.data(forKey: "OrderItems") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([OrderItem].self, from: items) {
                    self.items = decoded
                    return
                }
            }
            self.items = []
        
    }
}

struct OrderItem : Codable, Identifiable {
    let id: Int
    let name: String
    let phone: String
    let price: Double
    let description: String
    let due: String
}
