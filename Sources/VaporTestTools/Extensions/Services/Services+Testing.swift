//
//  Services+Testing.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 20/03/2018.
//

import Foundation
@testable import Service


extension Services {
    
    /// Remove particular service
    public mutating func remove<S>(type: S.Type) {
        if let existing = factories.index(where: {
            $0.serviceType is S.Type
        }) {
            factories.remove(at: existing)
        }
    }
    
}


