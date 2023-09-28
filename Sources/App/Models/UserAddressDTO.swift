//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 27/09/23.
//

import Foundation
import Vapor


public struct UserAddressDTO: Content {
    
    public var addressline1: String?
    public var addressline2: String?
    public var city: String?
    public var state: String?
    public var pincode: String?
    public var country: String?
    
    init(addressline1: String = "", addressline2: String = "", city: String = "", state: String = "", pincode: String = "", country: String = "") {
        self.addressline1 = addressline1
        self.addressline2 = addressline2
        self.city = city
        self.state = state
        self.pincode = pincode
        self.country = country
    }
}
