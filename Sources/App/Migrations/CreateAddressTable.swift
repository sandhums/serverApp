//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 13/09/23.
//

import Foundation
import Fluent

struct CreateAddressTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(Address.v1092023.schemaName)
            .id()
            .field(Address.v1092023.addressline1, .string)
            .field(Address.v1092023.addressline2, .string)
            .field(Address.v1092023.city, .string)
            .field(Address.v1092023.state, .string)
            .field(Address.v1092023.pincode, .string)
            .field(Address.v1092023.country, .string)
            .field(Address.v1092023.userID, .uuid, .required, .references("users", "id")).unique(on: Address.v1092023.userID)

            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema(Address.v1092023.schemaName)
            .delete()
    }
}
extension Address {
  // 1
  enum v1092023 {
    // 2
    static let schemaName = "addresses"
    //
    static let id = FieldKey(stringLiteral: "id")
    static let addressline1 = FieldKey(stringLiteral: "addressline1")
    static let addressline2 = FieldKey(stringLiteral: "addressline2")
    static let city = FieldKey(stringLiteral: "city")
    static let state = FieldKey(stringLiteral: "state")
    static let pincode = FieldKey(stringLiteral: "pincode")
    static let country = FieldKey(stringLiteral: "country")
    static let userID = FieldKey(stringLiteral: "userID")
   
  }
}
