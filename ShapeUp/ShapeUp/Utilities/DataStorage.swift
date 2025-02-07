//
//  DataStorage.swift
//  ShapeUp
//
//  Created by Clay Morton on 2/7/25.
//

import Foundation

class DataStorage {
    static func save<T: Encodable>(_ object: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(type, from: data) {
                return decoded
            }
        }
        return nil
    }
}
