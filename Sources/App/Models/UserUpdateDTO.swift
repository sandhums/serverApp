//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 19/09/23.
//

import Foundation
import Vapor


public struct UserUpdateDTO: Content {
    
    public var prefix: String?
    public var firstname: String?
    public var lastname: String?
    public var suffix: String?
    public var mobile: String?
    public var profilepicture: String?
    
    init(prefix: String = "", firstname: String = "", lastname: String = "", suffix: String = "", mobile: String = "", profilepicture: String = "") {
        self.prefix = prefix
        self.firstname = firstname
        self.lastname = lastname
        self.suffix = suffix
        self.mobile = mobile
        self.profilepicture = profilepicture
    }
}
