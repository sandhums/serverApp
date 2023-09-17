//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 15/09/23.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {
    
    typealias payload = AuthPayload
// MARK: TODO
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case userId = "uid"
    }
    
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var userId: UUID
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}

