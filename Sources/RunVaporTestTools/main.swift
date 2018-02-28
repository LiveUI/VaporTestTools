import AppVaporTestTools
import Service
import Vapor
import Foundation

// The contents of main are wrapped in a do/catch block because any errors that get raised to the top level will crash Xcode
do {
    var config = Config.default()
    var env = try Environment.detect()
    var services = Services.default()
    
    try AppVaporTestTools.configure(&config, &env, &services)
    
    let app = try Application(
        config: config,
        environment: env,
        services: services
    )
    
    try AppVaporTestTools.boot(app)
    
    try app.run()
} catch {
    print(error)
    exit(1)
}
