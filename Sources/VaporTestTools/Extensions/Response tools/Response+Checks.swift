//
//  Response+Checks.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
@testable import Vapor
@testable import NIO


extension TestableProperty where TestableType: Response {
    
    public func has(header name: HTTPHeaderName, value: String? = nil) -> Bool {
        guard let header = header(name: name) else {
            return false
        }
        
        if let value = value {
            // QUESTION: Do we want to be specific and use ==?
            return header.contains(value)
        }
        else {
            return true
        }
    }
    
    public func has(header name: String, value: String? = nil) -> Bool {
        let headerName = HTTPHeaderName(name)
        return has(header: headerName, value: value)
    }
    
    public func has(contentType value: String) -> Bool {
        let headerName = HTTPHeaderName("Content-Type")
        return has(header: headerName, value: value)
    }
    
    public func has(contentLength value: Int) -> Bool {
        let headerName = HTTPHeaderName("Content-Length")
        return has(header: headerName, value: String(value))
    }
    
    public func has(statusCode value: HTTPStatus) -> Bool {
        return has(statusCode: value)
    }
    
    public func has(statusCode value: HTTPStatus, message: String) -> Bool {
        return element.http.status.code == value.code && element.http.status.reasonPhrase == message
    }
    
    public func has(content value: String) -> Bool {
        return contentString == value
    }
    
}
