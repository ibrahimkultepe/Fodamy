//
//  RegisterRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 13.06.2023.
//

public struct RegisterRequest: APIDecodableResponseRequest {

    public typealias ResponseType = Auth

    public let path: String = "auth/register"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(userName: String, email: String, password: String) {
        self.parameters["username"] = userName
        self.parameters["email"] = email
        self.parameters["password"] = password
    }
}
