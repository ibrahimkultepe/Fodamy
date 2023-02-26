//
//  DataProviderProtocol.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

typealias DataProviderResult<T: Decodable> = ((Result<T, Error>) -> Void)

protocol DataProviderProtocol {
    
    func request<T: DecodableResponseRequest>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
}
