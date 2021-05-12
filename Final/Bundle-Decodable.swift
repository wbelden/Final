//
//  Bundle-Decodable.swift
//  Final
//
//  Created by Wade Belden on 5/7/21.
//

import Foundation

extension Bundle{
    func decode(_ file: String) -> [OrderItem] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode([OrderItem].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
