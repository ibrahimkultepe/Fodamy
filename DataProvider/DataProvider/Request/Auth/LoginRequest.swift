//
//  LoginRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 16.06.2023.
//

public struct LoginRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public let path: String = "auth/login"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(userName: String, password: String) {
        parameters["username"] = userName
        parameters["password"] = password
    }
}
