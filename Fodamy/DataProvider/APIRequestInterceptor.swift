//
//  APIRequestInterceptor.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 3.03.2023.
//

import Alamofire
import KeychainSwift

public class APIRequestInterceptor: RequestInterceptor {
    
    public static let shared = APIRequestInterceptor()
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        let accessToken = KeychainSwift().get(Keychain.token)
        
        if let accessToken = accessToken {
            urlRequest.headers.add(name: "X-Fodamy-Token", value: accessToken)
        }

        completion(.success(urlRequest))
    }
}
