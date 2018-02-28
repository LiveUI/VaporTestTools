//
//  GenericControllerTests.swift
//  AppTests
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

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
        
        res.testable.debug()
        
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
