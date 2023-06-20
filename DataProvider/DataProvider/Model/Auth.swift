//
//  Auth.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 19.06.2023.
//

public struct Auth: Decodable {
    public let token: String
    public let user: User
}
