//
//  HTTPHeaders+Tools.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 28/02/2018.
//

import Foundation
import Vapor


extension TestableProperty where TestableType == Dictionary<String, String> {
    
    func asHTTPHeaders() -> HTTPHeaders {
        var headersObject = HTTPHeaders()
        for key in element.keys {
            let value = element[key]
            headersObject[HTTPHeaderName(key)] = value
        }
        return headersObject
    }
    
}
