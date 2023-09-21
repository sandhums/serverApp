//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 13/09/23.
//

import Foundation

import Foundation
import Fluent

struct CreateUsersTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(User.v1092023.schemaName)
            .id()
            .field(User.v1092023.prefix, .string)
            .field(User.v1092023.firstname, .string)
            .field(User.v1092023.lastname, .string)
            .field(User.v1092023.suffix, .string)
            .field(User.v1092023.email, .string, .required).unique(on: User.v1092023.email)
            .field(User.v1092023.password, .string, .required)
            .field(User.v1092023.mobile, .string).unique(on: User.v1092023.mobile)
            .field(User.v1092023.roles, .array(of: .string))
            .field(User.v1092023.profilepicture, .string)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema(User.v1092023.schemaName)
            .delete()
    }
}
extension User {
    // 1
    enum v1092023 {
        // 2
        static let schemaName = "users"
        // 3
        static let id = FieldKey(stringLiteral: "id")
        static let prefix = FieldKey(stringLiteral: "prefix")
        static let firstname = FieldKey(stringLiteral: "firstname")
        static let lastname = FieldKey(stringLiteral: "lastname")
        static let suffix = FieldKey(stringLiteral: "suffix")
        static let email = FieldKey(stringLiteral: "email")
        static let password = FieldKey(stringLiteral: "password")
        static let mobile = FieldKey(stringLiteral: "mobile")
        static let roles = FieldKey(stringLiteral: "roles")
        static let profilepicture = FieldKey(stringLiteral: "profilepicture")
        
    }
}
