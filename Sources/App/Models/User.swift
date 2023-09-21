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
    
    @OptionalField(key: "profilepicture")
    var profilepicture: String?
    
//    
//    @OptionalChild(for: \.$user)
//    var address: Address?
    
    
    init() {}
    
    init(id: UUID? = nil, prefix: String? = nil, firstname: String? = nil, lastname: String? = nil, suffix: String? = nil, email: String, password: String, mobile: String? = nil, roles: [Roles] = [], profilepicture: String? = nil) {
        self.id = id
        self.prefix = prefix
        self.firstname = firstname
        self.lastname = lastname
        self.suffix = suffix
        self.email = email
        self.password = password
        self.mobile = mobile
        self.roles = roles
        self.profilepicture = profilepicture
        
    }
    
    init(prefix: String? = nil, firstname: String? = nil, lastname: String? = nil, suffix: String? = nil, mobile: String? = nil, roles: [Roles] = [], profilepicture: String? = nil) {
      
        self.prefix = prefix
        self.firstname = firstname
        self.lastname = lastname
        self.suffix = suffix
        self.mobile = mobile
        self.roles = roles
        self.profilepicture = profilepicture
        
    }
    
    final class Public: Content {
        var id: UUID?
        var prefix: String
        var firstname: String
        var lastname: String
        var suffix: String
        var mobile: String
        var profilepicture: String
        
        init(id: UUID? = nil, prefix: String, firstname: String, lastname: String, suffix: String, mobile: String, profilepicture: String) {
            self.id = id
            self.prefix = prefix
            self.firstname = firstname
            self.lastname = lastname
            self.suffix = suffix
            self.mobile = mobile
            self.profilepicture = profilepicture
        }
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("email", as: String.self, is: !.empty, customFailureDescription: "email cannot be empty")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "password cannot be empty")
        validations.add("password", as: String.self, is: .count(6...10), customFailureDescription: "password has to be between 6 and 10 characters")
    }
}


extension User {
  // 1
    func convertToPublic() -> User.Public {
    // 2
        return User.Public(id: id, prefix: prefix ?? "", firstname: firstname ?? "", lastname: lastname ?? "", suffix: suffix ?? "", mobile: mobile ?? "", profilepicture: profilepicture ?? "")
  }
}

// 1
extension EventLoopFuture where Value: User {
  // 2
  func convertToPublic() -> EventLoopFuture<User.Public> {
    // 3
    return self.map { user in
      // 4
      return user.convertToPublic()
    }
  }
}

// 5
extension Collection where Element: User {
  // 6
  func convertToPublic() -> [User.Public] {
    // 7
    return self.map { $0.convertToPublic() }
  }
}

// 8
extension EventLoopFuture where Value == Array<User> {
  // 9
  func convertToPublic() -> EventLoopFuture<[User.Public]> {
    // 10
    return self.map { $0.convertToPublic() }
  }
}





