//
//  TestableProperty.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation


public struct TestableProperty<TestableType> {
    
    public var element: TestableType
    
    init(_ obj: TestableType) {
        element = obj
    }
    
}
