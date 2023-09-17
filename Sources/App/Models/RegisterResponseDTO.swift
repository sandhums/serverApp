//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 15/09/23.
//

import Foundation
import Vapor

public struct RegisterResponseDTO: Content {
    public let error: Bool
    public var reason: String? = nil
    
    public init(error: Bool, reason: String? = nil) {
        self.error = error
        self.reason = reason
    }
}
