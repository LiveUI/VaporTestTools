import Foundation
import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("ping") { (req)->Future<MyObject> in
        let ping = "{ \"code\": \"pong\" }"
        return try JSONDecoder().decode(MyObject.self, from: HTTPBody(string: ping))
    }
    
    // Example of creating a Service and using it.
    router.get("hash", String.parameter) { req -> String in
        // Create a BCryptHasher using the Request's Container
        let hasher = try req.make(BCryptHasher.self)

        // Fetch the String parameter (as described in the route)
        let string = try req.parameter(String.self)

        // Return the hashed string!
        return try hasher.make(string)
    }
}
