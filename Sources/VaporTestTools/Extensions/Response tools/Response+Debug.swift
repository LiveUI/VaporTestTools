//
//  Response+Debug.swift
//  VaporTestTools
//
//  Created by Ondrej Rafaj on 27/02/2018.
//

import Foundation
@testable import Vapor


extension TestableProperty where TestableType: Response {
    
    /// Prints out useful information out the response
    public func debug() {
        print("Debugging response:")
        print("HTTP [\(element.version.major).\(element.version.minor)] with status code [\(element.status.code)]")
        print("Headers:")
        for header in element.headers {
            print("\t\(header.name.description) = \(header.value)")
        }
        print("Content:")
//        if let size = element.content.container.body.count {
//            print("\tSize: \(String(size))")
//        }
//        if let mediaType = element.content.container.contentType {
//            print("\tMedia type: \(mediaType.description)")
//        }
        if let stringContent = element.testable.contentString {
            print("\tContent:\n\(stringContent)")
        }
    }
    
}
