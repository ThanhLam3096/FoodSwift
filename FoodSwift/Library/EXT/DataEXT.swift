//
//  DataEXT.swift
//  FoodSwift
//
//  Created by Thanh Lâm on 15/10/24.
//

import Foundation

typealias JSON = [String: Any]

extension Data {
    func toJSON() -> JSON? {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON {
                json = jsonObj
            }
        } catch {
            print("Data Can't Format")
        }
        return json
    }

    func toArrayJSON() -> [JSON] {
        var json: [[String: Any]] = []
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [JSON] {
                json = jsonObj
            }
        } catch {
            print("Data Can't Format")
        }
        return json
    }
    
    func toJSONAny() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            return nil
        }
    }
    static func decodeBase64(strBase64: String) -> Data? {
        return Data(base64Encoded: strBase64, options: .init(rawValue: 0))
    }
}
