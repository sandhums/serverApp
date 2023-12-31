//
//  File.swift
//  
//
//  Created by Manjinder Sandhu on 13/09/23.
//

import Foundation
import Vapor
import Fluent
import HISSharedDTO


class UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let his = routes.grouped("his")
        let hisusers = routes.grouped("his", "users", ":userId").grouped(JSONWebTokenAuthenticator())
        
        // /api/register
        his.post("register", use: register)
        // /api/login
        his.post("login", use: login)
        
        his.get("users", use: getAllUsers)
        
        hisusers.patch("update", use: updateUser)
        hisusers.get("getprofile", use: getUserProfile)
      
        
        func login (req: Request) async throws -> LoginResponseDTO {
            
            // decode the request
            let user = try req.content.decode(User.self)
            
            // check if user exists in db
            guard let existingUser = try await User.query(on: req.db) // guard let because first() returns optional
                .filter(\.$email == user.email)
                .first() else {
                  return LoginResponseDTO(error: true, reason: "Email does not exist")
                }
            // validate the password
            let result = try await req.password.async.verify(user.password, created: existingUser.password)
            
            if !result {
                return LoginResponseDTO(error: true, reason: "Incorrect password")
            }
            
            // generate the token and return it to user - create AuthPayload
            
            let authPayload = try AuthPayload(subject: .init(value: "his App"), expiration: .init(value: .distantFuture), userId: existingUser.requireID())
            return try LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existingUser.requireID())
        }
        
        func register (req:Request) async throws -> RegisterResponseDTO {
            
            try User.validate(content: req)
            
            let user = try req.content.decode(User.self)
            // find if username already exists
            if let _ = try await User.query(on: req.db)
                .filter(\.$email == user.email)
                .first() {
                throw Abort(.conflict, reason: "Email is already taken")
            }
            // hash the password
            user.password = try await req.password.async.hash(user.password)
            
            try await user.save(on: req.db)
            
            return RegisterResponseDTO(error: false)
        }
        
        func getAllUsers(_ req: Request) async throws -> [User] {
          // 2
          try await User.query(on: req.db).all()
        }
        func updateUser(_ req: Request) async throws -> User.Public {
            
            guard let userId = req.parameters.get("userId", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            guard let user = try await User.find(userId, on: req.db) else {
                throw Abort(.notFound)
            }
            let userUpdateDTO = try req.content.decode(UserUpdateDTO.self)
            
            if let prefix = userUpdateDTO.prefix {
                user.prefix = prefix
              }
            
            if let firstname = userUpdateDTO.firstname {
                  user.firstname = firstname
              }
              // If new last name was supplied, update it.
            if let lastname = userUpdateDTO.lastname {
                  user.lastname = lastname
              }
            if let suffix = userUpdateDTO.suffix {
                user.suffix = suffix
              }
            if let mobile = userUpdateDTO.mobile {
                user.mobile = mobile
              }
            if let profilepicture = userUpdateDTO.profilepicture {
                user.profilepicture = profilepicture              }
           
            try await user.save(on: req.db)
            return user.convertToPublic()
            
        }
        func getUserProfile (_ req: Request) async throws -> User.Public {
            
            guard let userId = req.parameters.get("userId", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            guard let user = try await User.find(userId, on: req.db) else {
                throw Abort(.notFound)
            }
            return user.convertToPublic()
                
        }
    }
}

