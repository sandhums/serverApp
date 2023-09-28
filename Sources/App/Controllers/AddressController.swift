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
        let his = routes.grouped("his", "users", ":userId").grouped(JSONWebTokenAuthenticator())
        his.get("address", use: getAddress)
        his.post("address", use: saveAddress)
        his.put("address", use: updateAddress)
        }
        
    
    func getAddress(req: Request) async throws -> Address {
        
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }

      guard let address = try await Address.query(on: req.db)
            .filter(\.$user.$id == userId)
            .first() else {
          throw Abort(.notFound)
      }
        return address
    }
        func saveAddress(req: Request) async throws -> Address {
            // MARK: TODO - fix Abort.badrequest
            // get the userId
            guard let userId = req.parameters.get("userId", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            let data = try req.content.decode(UserAddressDTO.self)
          

            let address = Address(addressline1: data.addressline1 ?? "", addressline2: data.addressline2 ?? "", city: data.city ?? "", state: data.state ?? "", pincode: data.pincode ?? "", country: data.country ?? "", userID: userId)

            
             try await address.save(on: req.db)
            
            
            // DTO for the response
            return address
            
        }
    func updateAddress(req: Request) async throws -> Address {
        
        // get the userId
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let address = try await Address.query(on: req.db).filter(\.$user.$id == userId).first() else {
            throw Abort(.notFound)
        }
    
        let data = try req.content.decode(UserAddressDTO.self)
        
        if let addressline1 = data.addressline1 {
            address.addressline1 = addressline1
          }
        if let addressline2 = data.addressline2 {
            address.addressline2 = addressline2
          }
        if let city = data.city{
            address.city = city
          }
        if let state = data.state {
            address.state = state
          }
        if let pincode = data.pincode {
            address.pincode = pincode
          }
        if let country = data.country {
            address.country = country
          }
        try await address.update(on: req.db)
        
        
        // DTO for the response
        return address
        
    }
    }

