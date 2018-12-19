//
//  User.swift
//  App
//
//  Created by i.kharabet on 17.12.2018.
//

import FluentSQLite
import Vapor

final class User: SQLiteModel, Migration, Content, Parameter {
    var id: Int?
    
    var email: String
    var password: String
    
    init(id: Int? = nil, email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}
