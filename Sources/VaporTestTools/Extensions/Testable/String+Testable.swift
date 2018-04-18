//
//  String+Testable.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

@_exported import Foundation


extension TestableProperty where TestableType == String {
    
    /// Return data in utf8 encoding
    public func asData() -> Data? {
        let data = element.data(using: .utf8)
        return data
    }
    
}
