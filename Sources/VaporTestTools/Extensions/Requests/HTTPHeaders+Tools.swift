//
//  HTTPHeaders+Tools.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 28/02/2018.
//

@_exported import Foundation
@_exported import Vapor


extension TestableProperty where TestableType == Dictionary<String, String> {
    
    /// Converts dictionary into HTTPHeaders
    func asHTTPHeaders() -> HTTPHeaders {
        var headersObject = HTTPHeaders()
        for key in element.keys {
            let value = element[key]!
            headersObject.replaceOrAdd(name: key, value: value)
        }
        return headersObject
    }
    
}
