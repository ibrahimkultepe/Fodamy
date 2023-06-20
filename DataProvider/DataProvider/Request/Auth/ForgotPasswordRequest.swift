//
//  ForgotPasswordRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 17.06.2023.
//

public struct ForgotPasswordRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public let path: String = "auth/forgot"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(email: String) {
        parameters["email"] = email
    }
}
