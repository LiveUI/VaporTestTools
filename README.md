![Vapor 3 test tools](https://github.com/LiveUI/VaporTestTools/raw/master/Other/logo.png)

##

[![Slack](http://vapor.team/badge.svg?style=flat)](http://vapor.team)
[![Jenkins](https://ci.liveui.io/job/LiveUI/job/VaporTestTools/job/master/badge/icon)](https://ci.liveui.io/job/LiveUI/job/VaporTestTools/)
[![Platforms](https://img.shields.io/badge/platforms-macOS%2010.13%20|%20Ubuntu%2016.04%20LTS-ff0000.svg?style=flat)](https://github.com/LiveUI/VaporTestTools)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-CCCCCC.svg?style=flat)](http://cocoapods.org/pods/Presentables)
[![Platform](https://img.shields.io/badge/framework-Vapor3-FF0000.svg?style=flat)](http://cocoapods.org/pods/Presentables)

## 

Vaper test tools is (pretty much vhat it says on the tin) a set of methods designed to make testing your endpoints in Vapor 3 a bit more pain-free ...

## Slack

Get help using and/or installing this library on the Vapor [Slack](http://vapor.team), and look for <b>@rafiki270</b>

## Example

To run the example project on a mac, clone the repo, and run `vapor xcode` to generate xcode project and run `Run` target.

## Installation

#### SPM - Swift Package Manager

Import 

```swift
.package(url: "https://github.com/LiveUI/VaporTestTools.git", from: "0.1.1")

// or to always get the latest changes

.package(url: "https://github.com/LiveUI/VaporTestTools.git", .branch("master"))
```

## Usage

To write tests like this ...

```Swift
func testHello() {
    let req = HTTPRequest.testable.get(uri: "/hello")
    let res = app.testable.response(to: req).response

    res.testable.debug() // Debug response into the console
    
    let hello = res.testable.content(as: Hello.self)!
    XCTAssertEqual(hello.message, "hello world", "Message is incorrect")

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
        let r = app.testable.response(to: req)
        let res = r.response
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
        XCTAssertTrue(res.testable.has(contentType: "text/plain; charset=utf-8"), "Missing content type")
        XCTAssertTrue(res.testable.has(contentLength: 13), "Wrong content length")
        XCTAssertTrue(res.testable.has(content: "Hello, world!"), "Incorrect content")
    }
    
    func testPing() {
        let req = HTTPRequest.testable.get(uri: "/ping")
        let r = app.testable.response(to: req)
        let res = r.response
        
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
        let r = app.testable.response(to: req)
        let res = r.response
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: 404), "Wrong status code")
        XCTAssertFalse(res.testable.has(header: "Content-Type"), "Should not content type")
        XCTAssertTrue(res.testable.has(contentLength: 9), "Wrong content length")
        XCTAssertTrue(res.testable.has(content: "Not found"), "Incorrect content")
    }
    
    func testHash() {
        let req = HTTPRequest.testable.get(uri: "/hash/something")
        let r = app.testable.response(to: req)
        let res = r.response
        
        res.testable.debug()
        
        XCTAssertTrue(res.testable.has(statusCode: .ok), "Wrong status code")
        XCTAssertTrue(res.testable.has(contentType: "text/plain; charset=utf-8"), "Missing content type")
        XCTAssertTrue(res.testable.has(contentLength: 60), "Wrong content length")
    }
    
}

```

To see more examples in action, please see <b>VaporTestTools</b> in action:
* [Boost - Enterprise AppStore for mobile apps](https://github.com/LiveUI/Boost/)
   * [API core tests](https://github.com/LiveUI/Boost/tree/master/Tests/ApiCoreTests/Controllers)

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

## Example Package.swift for testing

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


Don't forget to star the repo if you think it deserves it! :)

Have fun testing!

## Boost - Open source enterprise AppStore

**VaporTestTools** has been released as a part of a Boost mobile app distribution platform.

More info on http://www.boostappstore.com

Other components in the bundle are:

* [BoostCore](https://github.com/LiveUI/BoostCore/) - AppStore core module
* [ApiCore](https://github.com/LiveUI/ApiCore/) - Base user & team management including forgotten passwords, etc ...
* [MailCore](https://github.com/LiveUI/MailCore/) - Mailing wrapper for multiple mailing services like MailGun, SendGrig or SMTP (coming)
* [DBCore](https://github.com/LiveUI/DbCore/) - Set of tools for work with PostgreSQL database


## Author

Ondrej Rafaj (@rafiki270 on [Github](https://github.com/rafiki270), [Twitter](https://twitter.com/rafiki270), [LiveUI Slack](http://bit.ly/2B0dEyt) and [Vapor Slack](https://vapor.team/))

## License

VaporTestTools are available under an MIT license. See the LICENSE file for more info.
