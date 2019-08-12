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
    
    /// Test header value
    public func has(header name: HTTPHeaders.Name, value: String? = nil) -> Bool {
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
    
    /// Test header value
    public func has(header name: String, value: String? = nil) -> Bool {
        let headerName = HTTPHeaders.Name(name)
        return has(header: headerName, value: value)
    }
    
    /// Test header Content-Type
    public func has(contentType value: String) -> Bool {
        let headerName = HTTPHeaders.Name("Content-Type")
        return has(header: headerName, value: value)
    }
    
    /// Test header Content-Length
    public func has(contentLength value: Int) -> Bool {
        let headerName = HTTPHeaders.Name("Content-Length")
        return has(header: headerName, value: String(value))
    }
    
    /// Test response status code
    public func has(statusCode value: HTTPStatus) -> Bool {
        return element.status.code == value.code
    }
    
    /// Test response status code and message
    public func has(statusCode value: HTTPStatus, message: String) -> Bool {
        return element.status.code == value.code && element.status.reasonPhrase == message
    }
    
    /// Test response content
    public func has(content value: String) -> Bool {
        return contentString == value
    }
    
}
