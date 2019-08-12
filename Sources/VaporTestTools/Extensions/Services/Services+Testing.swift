//
//  Services+Testing.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 20/03/2018.
//

import Foundation
@testable import Vapor


extension Services {
    
    /// Remove particular service
    public mutating func remove<S>(type: S.Type) {
        fatalError()
//        if let existing = factories.index(where: {
//            $0.serviceType is S.Type
//        }) {
//            factories.remove(at: existing)
//        }
    }
    
}


