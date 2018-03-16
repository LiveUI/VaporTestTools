//
//  HTTPRequest+Make.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
import Vapor
import Routing


public typealias URI = String


extension TestableProperty where TestableType == HTTPRequest {
    
    public static func request(method: HTTPMethod, uri: URI, data: Data? = nil, headers: [String: String]? = nil) -> HTTPRequest {
        var req = HTTPRequest(method: method, url: URL(string: uri)!)
        if let headers = headers {
            req.headers = headers.testable.asHTTPHeaders()
        }
        if let data = data {
            req.body = HTTPBody(data: data)
        }
        return req
    }
    
    public static func get(uri: URI, headers: [String: String]? = nil) -> HTTPRequest {
        let req = request(method: .GET, uri: uri, headers: headers)
        return req
    }
    
    public static func put(uri: URI, data: Data? = nil, headers: [String: String]? = nil) -> HTTPRequest {
        let req = request(method: .PUT, uri: uri, data: data, headers: headers)
        return req
    }
    
    public static func post(uri: URI, data: Data? = nil, headers: [String: String]? = nil) -> HTTPRequest {
        let req = request(method: .POST, uri: uri, data: data, headers: headers)
        return req
    }
    
    public static func patch(uri: URI, data: Data? = nil, headers: [String: String]? = nil) -> HTTPRequest {
        let req = request(method: .PATCH, uri: uri, data: data, headers: headers)
        return req
    }
    
    public static func delete(uri: URI, headers: [String: String]? = nil) -> HTTPRequest {
        let req = request(method: .DELETE, uri: uri, headers: headers)
        return req
    }
    
    public static func response(get uri: URI, headers: [String: String]? = nil, with app: Application) -> TestResponse {
        let req = request(method: .GET, uri: uri, headers: headers)
        return app.testable.response(to: req)
    }
    
    public static func response(put uri: URI, data: Data? = nil, headers: [String: String]? = nil, with app: Application) -> TestResponse {
        let req = request(method: .PUT, uri: uri, data: data, headers: headers)
        return app.testable.response(to: req)
    }
    
    public static func response(post uri: URI, data: Data? = nil, headers: [String: String]? = nil, with app: Application) -> TestResponse {
        let req = request(method: .POST, uri: uri, data: data, headers: headers)
        return app.testable.response(to: req)
    }
    
    public static func response(patch uri: URI, data: Data? = nil, headers: [String: String]? = nil, with app: Application) -> TestResponse {
        let req = request(method: .PATCH, uri: uri, data: data, headers: headers)
        return app.testable.response(to: req)
    }
    
    public static func response(delete uri: URI, headers: [String: String]? = nil, with app: Application) -> TestResponse {
        let req = request(method: .DELETE, uri: uri, headers: headers)
        return app.testable.response(to: req)
    }
    
}
