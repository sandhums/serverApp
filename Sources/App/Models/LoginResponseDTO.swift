//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 15/09/23.
//

import Foundation
import Vapor

public struct LoginResponseDTO: Content {
    public let error: Bool
    public var reason: String? = nil
    public var token: String? = nil
    public var userId: UUID? = nil
    
    public init(error: Bool, reason: String? = nil, token: String? = nil, userId: UUID? = nil) {
        self.error = error
        self.reason = reason
        self.token = token
        self.userId = userId
    }
}
