//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 17/09/23.
//

import Foundation
import Vapor

struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {
    
    func authenticate(request: Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }
    
}
