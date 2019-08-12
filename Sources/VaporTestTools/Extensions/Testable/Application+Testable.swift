//
//  Application+Testable.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
import Vapor


/// Response tuple containing response as well as the request
public typealias TestResponse = Response


extension TestableProperty where TestableType: Container {
    
    public typealias AppConfigClosure = ((_ s: inout Services) -> Void)
    public typealias AppRouterClosure = ((_ router: Router) -> Void)
    
    /// Configure a new test app (in test setup)
    public static func new(env: Environment? = nil, _ configClosure: AppConfigClosure? = nil, _ routerClosure: AppRouterClosure) -> Application {
        var services = Services()

        configClosure?(&services)
        let app = try! Application(environment: env ?? .detect(), configure: configClosure ?? { _ in })

        let router = Router
        routerClosure(router)

        return app
    }
    
    /// Respond to Request
    public func response(to request: Request) -> TestResponse {
        let responder = try! element.make(Responder.self)
        return try! responder.respond(to: request).wait()
    }
    
    /// Respond to Request (throwing)
    public func response(throwingTo request: Request) throws -> TestResponse {
        let responder = try element.make(Responder.self)
        return try responder.respond(to: request).wait()
    }
    
    /// Create fake request
    public func fakeRequest() -> Request {
        let channel = EmbeddedChannel()
        let req = Request(method: .GET, url: "/", on: channel)
        return req
    }
    
}

