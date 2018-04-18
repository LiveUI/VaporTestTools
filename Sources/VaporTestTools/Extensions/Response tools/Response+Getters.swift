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
        let http = HTTPRequest(method: .GET, url: URL(string: "/")!)
        let req = Request(http: http, using: element)
        return req
    }
    
    /// Get header by it's name
    public func header(name: String) -> String? {
        let headerName = HTTPHeaderName(name)
        return header(name: headerName)
    }
    
    /// Get header by it's HTTPHeaderName representation
    public func header(name: HTTPHeaderName) -> String? {
        return element.http.headers[name].first
    }
    
    /// Size of the content
    public var contentSize: Int? {
        return element.content.container.http.body.data?.count
    }
    
    /// Get content string. Maximum of 0.5Mb of text will be returned
    public var contentString: String? {
        guard let data = try? element.content.container.http.body.consumeData(max: 500000, on: fakeRequest()).wait() else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    /// Get content string with encoding. Maximum of 0.5Mb of text will be returned
    public func contentString(encoding: String.Encoding) -> String? {
        guard let data = try? element.content.container.http.body.consumeData(max: 500000, on: fakeRequest()).wait() else {
            return nil
        }
        return String(data: data, encoding: encoding)
    }
    
}
