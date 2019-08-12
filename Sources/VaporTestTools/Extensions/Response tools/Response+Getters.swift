//
//  Response+Getters.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
@testable import Vapor
@testable import NIO


extension TestableProperty where TestableType: Response {
    
    /// Make a fake request
    public func fakeRequest() -> Request {
        let channel = EmbeddedChannel()
        let req = Request(method: .GET, url: "/", on: channel)
        return req
    }
    
    /// Get header by it's name
    public func header(name: String) -> String? {
        let headerName = HTTPHeaders.Name(name)
        return header(name: headerName)
    }
    
    /// Get header by it's HTTPHeaders.Name representation
    public func header(name: HTTPHeaders.Name) -> String? {
        return element.headers[name].first
    }
    
    /// Size of the content
    public var contentSize: Int? {
        return element.body.buffer?.readableBytes
    }
    
    /// Get content string. Maximum of 0.5Mb of text will be returned
    public var contentString: String? {
        return contentString(encoding: .utf8)
    }
    
    /// Get content string with encoding. Maximum of 0.5Mb of text will be returned
    public func contentString(encoding: String.Encoding) -> String? {
        guard var b = element.body.buffer, let data = b.readData(length: b.readableBytes) else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
    
}
