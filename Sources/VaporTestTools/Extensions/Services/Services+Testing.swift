//
//  Services+Testing.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 20/03/2018.
//

import Foundation
@testable import Service


extension TestableProperty where TestableType == Services {
    
    public mutating func remove<S>(type: S.Type) {
        if let existing = element.factories.index(where: {
            $0.serviceType is S.Type
        }) {
            element.factories.remove(at: existing)
        }
    }
    
}


