//
//  HTTPRequest+Response.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

@_exported import Foundation
@_exported import Vapor
@_exported @testable import NIO


extension TestableProperty where TestableType == Request {
    
    /// Make response
    func response(using c: Container) -> Response {
        let responder = try! c.make(Responder.self)
        return try! responder.respond(to: element).wait()
    }
    
}
