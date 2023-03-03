//
//  DecodableResponseRequest.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

public protocol DecodableResponseRequest: RequestProtocol {
   associatedtype ResponseType: Decodable
}
