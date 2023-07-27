//
//  LogoutRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 26.07.2023.
//

public struct LogoutRequest: APIDecodableResponseRequest {
    
    public typealias ResponseType = SuccessResponse

    public let path: String = "auth/logout"
    public let method: RequestMethod = .post
    
    public init() {}
}
