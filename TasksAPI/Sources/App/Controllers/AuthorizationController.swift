//
//  AuthorizationController.swift
//  App
//
//  Created by i.kharabet on 17.12.2018.
//

import Vapor

final class AuthorizationController {
    
    func authorize(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.content
            .decode(User.self)
            .flatMap { user in
                return AuthorizationController.findUser(req: req,
                                                        email: user.email,
                                                        password: user.password)
                    .and(result: user)
            }
            .flatMap { cachedUser, user in
                if let cachedUser = cachedUser {
                    return HTTPStatus.ok.encode(for: req)
                } else {
                    return user.save(on: req)
                }
            }
            .transform(to: .ok)
    }
    
    private static func findUser(req: Request, email: String, password: String) -> Future<User?> {
        return User.query(on: req)
            .filter(\User.email, .equal, email)
            .filter(\User.password, .equal, password)
            .first()
    }
    
}
