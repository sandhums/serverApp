//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 12/09/23.
//

import Foundation
import Vapor
import Fluent
/// Define a class that conforms to Model, Content - Conformance to this protocol consists of: Codable, RequestDecodable, ResponseEncodable, Validatable - Capable of being validated. Conformance adds a throwing validate() method
final class User: Model, Content, Validatable {
    
    /// Specify the schema as required by Model. This is the name of the table in the database.
    static let schema = "users"
    
    /// @ID marks a property as the ID for that table. Fluent uses this property wrapper to perform queries in the database when finding models. The property wrapper is also used for relationships. By default in Fluent, the ID must be a UUID and called id.
    @ID(key: .id)
    var id: UUID?
    
    /// @Field property wrapper to denote a generic database field. The key parameter is the name of the column in the database.
    @OptionalField(key: "prefix")
    var prefix: String?
    
    @OptionalField(key: "firstname")
    var firstname: String?
    
    @OptionalField(key: "lastname")
    var lastname: String?
    
    @OptionalField(key: "suffix")
    var suffix: String?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String
    
    @OptionalField(key: "mobile")
    var mobile: String?
    
    @OptionalField(key: "roles")
    var roles: [Roles]?
    
//    @Group(key: "address")
//    var address: Address?
    
    @OptionalChild(for: \.$user)
    var address: Address?

    
    init() {}
    
    init(id: UUID? = nil, email: String, password: String) {
      self.id = id
      self.email = email
      self.password = password
     
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("email", as: String.self, is: !.empty, customFailureDescription: "email cannot be empty")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "password cannot be empty")
        validations.add("password", as: String.self, is: .count(6...10), customFailureDescription: "password has to be between 6 and 10 characters")
    }
}


