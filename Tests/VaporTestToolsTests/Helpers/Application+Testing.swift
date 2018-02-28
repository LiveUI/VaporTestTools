//
//  Application+Testing.swift
//  AppTests
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
import AppVaporTestTools
import Vapor
import VaporTestTools


extension TestableProperty where TestableType: Application {
    
    public static func newTestApp() -> Application {
        let app = new({ (config, env, services) in
            try! AppVaporTestTools.configure(&config, &env, &services)
        }) { (router) in
            
        }
        try! AppVaporTestTools.boot(app)
        return app
    }
    
}
