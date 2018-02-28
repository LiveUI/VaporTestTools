# VaporTestTools

[![Slack](http://vapor.team/badge.svg?style=flat)](http://vapor.team)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-CCCCCC.svg?style=flat)](http://cocoapods.org/pods/Presentables)
[![Platform](https://img.shields.io/badge/framework-Vapor3-FF0000.svg?style=flat)](http://cocoapods.org/pods/Presentables)

## 

Vaper test tools is (pretty much vhat it says on the tin) a set of methods designed to make testing your endpoints in Vapor 3 a bit more pain-free ...

## Slack

Get help using and installing this library on the Vapor [Slack](http://vapor.team), and look for <b>@rafiki270</b>

## Example

To run the example project on a mac, clone the repo, and run `vapor xcode` to generate xcode project and run `Run` target.

## Installation

#### SPM - Swift Package Manager

Import 

```swift
.package(url: "https://github.com/LiveUI/VaporTestTools.git", from: "0.0.1")

// or to always get the latest changes

.package(url: "https://github.com/LiveUI/VaporTestTools.git", .branch("master"))
```

Your whole `Package.swift` file could look something like this:
```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "MyApp",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-beta.3.1.3"),
        .package(url: "https://github.com/LiveUI/VaporTestTools.git", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: [
                "Vapor"
            ]
        ),
        .target(name: "Run", dependencies: [
            "MyApp"
            ]),
        .testTarget(name: "AppTests", dependencies: ["TestApp", "VaporTestTools"])
    ]
)
```

Notice the line `.testTarget(name: "AppTests", dependencies: ["TestApp", "VaporTestTools"])` where you create a test target and include `VaporTestTools`.


## Usage

To write tests like this ...

```Swift
func testHello() {
    let req = HTTPRequest.testable.get(uri: "/hello")
    let res = app.testable.response(to: req)

    res.testable.debug() // Debug response into the console

    XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
    XCTAssertTrue(res.testable.has(contentType: "text/plain; charset=utf-8"), "Missing content type")
    XCTAssertTrue(res.testable.has(contentLength: 13), "Wrong content length")
    XCTAssertTrue(res.testable.has(content: "Hello, world!"), "Incorrect content")
}

```

... you first you need to configure your `Application` object in a test environment. To do that I would recommend creating some form of a helper method that would allow you to access the functionality from any file.

```swift
let app = Application.testable.new({ (config, env, services) in
    try! App.configure(&config, &env, &services)
}) { (router) in

}
```
<i>I would recommend to put the above initialization in a convenience method as described [here](#custom-application-convenience-method)</i>

And finally create your test file ... the whole thing could look like this:

```Swift
import XCTest
import Vapor
import VaporTestTools


class GenericControllerTests: XCTestCase {
    
    var app: Application!
    
    // MARK: Linux
    
    static let allTests = [
        ("testHello", testHello),
        ("testPing", testPing),
        ("testNotFound", testNotFound),
        ("testHash", testHash)
    ]

    
    // MARK: Setup
    
    override func setUp() {
        super.setUp()
        
        app = Application.testable.newTestApp()
    }
    
    // MARK: Tests
    
    func testHello() {
        let req = HTTPRequest.testable.get(uri: "/hello")
        let res = app.testable.response(to: req)
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
        XCTAssertTrue(res.testable.has(contentType: "text/plain; charset=utf-8"), "Missing content type")
        XCTAssertTrue(res.testable.has(contentLength: 13), "Wrong content length")
        XCTAssertTrue(res.testable.has(content: "Hello, world!"), "Incorrect content")
    }
    
    func testPing() {
        let req = HTTPRequest.testable.get(uri: "/ping")
        let res = app.testable.response(to: req)
        
        // Print out info about the Response
        res.testable.debug()
        /*
        Debugging response:
        HTTP [1.1] with status code [200]
        Headers:
            Content-Type = application/json; charset=utf-8
            Content-Length = 15
            Date = Wed, 28 Feb 2018 00:52:02 GMT
        Content:
            Size: 15
            Media type: application/json; charset=utf-8
            Content:
        {"code":"pong"}
        */
        
        XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
        XCTAssertTrue(res.testable.has(contentType: "application/json; charset=utf-8"), "Missing content type")
        XCTAssertTrue(res.testable.has(contentLength: 15), "Wrong content length")
        XCTAssertTrue(res.testable.has(content: "{\"code\":\"pong\"}"), "Incorrect content")
    }
    
    func testNotFound() {
        let req = HTTPRequest.testable.get(uri: "/not-found")
        let res = app.testable.response(to: req)
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: 404), "Wrong status code")
        XCTAssertFalse(res.testable.has(header: "Content-Type"), "Should not content type")
        XCTAssertTrue(res.testable.has(contentLength: 9), "Wrong content length")
        XCTAssertTrue(res.testable.has(content: "Not found"), "Incorrect content")
    }
    
    func testHash() {
        let req = HTTPRequest.testable.get(uri: "/hash/something")
        let res = app.testable.response(to: req)
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
        XCTAssertTrue(res.testable.has(contentType: "text/plain; charset=utf-8"), "Missing content type")
        XCTAssertTrue(res.testable.has(contentLength: 60), "Wrong content length")
    }
    
}

```

#### Custom `Application` convenience method

In the following example (`Application+Testing.swift`) you can see an extension on a testable property which holds all the convenience methods. This will be available through `Application.testable.newTestApp()`

```Swift
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
        return app
    }
    
}
```

Enjoy and let me know what you think ;)

## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

VaporTestTools are available under an MIT license. See the LICENSE file for more info.
