//
//  Encodable+Testable.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation


extension TestableProperty where TestableType: Encodable {
    
    /// Convert to Data
    public func asData() -> Data? {
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(element)
        return jsonData
    }
    
}
