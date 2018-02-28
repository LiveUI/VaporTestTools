//
//  Application+Testing.swift
//  AppTests
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
import App
import Vapor
import VaporTestTools


extension TestableProperty where TestableType: Application {
    
    public static func newTestApp() -> Application {
        let app = new({ (config, env, services) in
            try! App.configure(&config, &env, &services)
        }) { (router) in
            
        }
        try! App.boot(app)
        return app
    }
    
}
