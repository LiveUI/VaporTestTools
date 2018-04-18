//
//  HTTPRequest+Response.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

@_exported import Foundation
@_exported import Vapor
@_exported @testable import NIO


extension TestableProperty where TestableType == HTTPRequest {
    
    /// Make response
    func response(using app: Application) -> Response {
        let responder = try! app.make(Responder.self)
        let wrappedRequest = Request(http: element, using: app)
        return try! responder.respond(to: wrappedRequest).wait()
    }
    
}
