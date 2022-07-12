//
//  Session.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 15.02.2022.
//

import Foundation
import FirebaseDatabase

class Session {

    static let instance = Session()

    private init() {}
    
    let usersRef = Database.database().reference(withPath: "Users")
    var sessionUserRef = Database.database().reference()
    
//    var id: Int?
//    var token: String?
    
    var token = "b8c6a0a95d35b64dd7185c1e50d8cad5c2e82a469bb4ff8a45c553a5cc93f324a72e63af53d4c0e2a6721"
    var id = 18052852
}
