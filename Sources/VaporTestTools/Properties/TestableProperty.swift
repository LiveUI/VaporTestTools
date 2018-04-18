//
//  TestableProperty.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

@_exported import Foundation


public struct TestableProperty<TestableType> {
    
    /// Testable element accessor
    public var element: TestableType
    
    init(_ obj: TestableType) {
        element = obj
    }
    
}
