//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 13/09/23.
//

import Foundation
import Fluent
import Vapor

final class Address: Model, Content {
    
    static let schema = "addresses"
    
    @ID
    var id: UUID?
    
    @OptionalField(key: "addressline1")
    var addressline1: String?
    
    @OptionalField(key: "addressline2")
    var addressline2: String?
    
    @OptionalField(key: "city")
    var city: String?
    
    @OptionalField(key: "state")
    var state: String?
    
    @OptionalField(key: "pincode")
    var pincode: String?
    
    @OptionalField(key: "country")
    var country: String?
    
    @Parent(key: "userID")
    var user: User
    
    init() {}
    
    init(id: UUID? = nil, addressline1: String, addressline2: String, city: String, state: String, pincode: String, country: String, userID: User.IDValue) {
        self.id = id
        self.addressline1 = addressline1
        self.addressline2 = addressline2
        self.city = city
        self.state = state
        self.pincode = pincode
        self.country = country
        self.$user.id = userID
    
    }
}
