//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 15/09/23.
//

import Foundation
import Vapor
import Fluent

class AddressController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
       let his = routes.grouped("his", "users", ":userId")
        
        his.post("address", use: saveAddress)
        
        func saveAddress(req: Request) async throws -> Address {
            
            // get the userId
            guard let userId = req.parameters.get("userId", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            
            // DTO for the request
//            let groceryCategoryRequestDTO = try req.content.decode(GroceryCategoryRequestDTO.self)
            let data = try req.content.decode(createAddressData.self)
            
            let address = Address(addressline1: data.add1, addressline2: data.add2, city: data.city, state: data.state, pincode: data.pincode, country: data.country, userID: userId)
//            let groceryCategory = GroceryCategory(title: groceryCategoryRequestDTO.title, colorCode: groceryCategoryRequestDTO.colorCode, userId: userId)
            
             try await address.save(on: req.db)
            
//            guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
//                throw Abort(.internalServerError)
//            }
            
            // DTO for the response
            return address
            
        }
    }
}

struct createAddressData: Content {
    let add1: String
    let add2: String
    let city: String
    let state: String
    let pincode: String
    let country: String
    let userID: UUID
}
