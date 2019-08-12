//
//  TestTools.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

@_exported import Foundation
@_exported import Vapor


// MARK: Testable

/// Testable protocol
public protocol Testable {
    /// Supported testable type
    associatedtype ObjectType
    
    /// Main property to access VaporTestTools functionality on supported projects
    var testable: TestableProperty<ObjectType> { get }
    
    /// Main static property to access VaporTestTools functionality on supported projects
    static var testable: TestableProperty<ObjectType>.Type { get }
}


extension Testable {
    
    /// Main property to access VaporTestTools functionality on supported projects
    public var testable: TestableProperty<Self> {
        return TestableProperty(self)
    }
    
    /// Main static property to access VaporTestTools functionality on supported projects
    public static var testable: TestableProperty<ObjectType>.Type {
        return TestableProperty<ObjectType>.self
    }
    
}

// MARK: Supported types

extension Request: Testable { }
extension Response: Testable { }
extension Application: Testable { }

/// Testable for dictionaries
extension Dictionary: Testable where Key == String, Value == String {
    public typealias ObjectType = [String : String]
}




