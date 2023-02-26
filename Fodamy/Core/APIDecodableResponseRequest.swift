//
//  APIDecodableResponseRequest.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

protocol APIDecodableResponseRequest: DecodableResponseRequest {}

// MARK: - RequestEncoding
extension APIDecodableResponseRequest {
    var encoding: RequestEncoding {
        switch method {
        case .get:
            return .url
        default:
            return .json
        }
    }
}

// MARK: - url
extension APIDecodableResponseRequest {
    var url: String {
        return "https://api.spacexdata.com/v4/launches/" + path
    }
}

// MARK: - RequestParameters
extension APIDecodableResponseRequest {
    var parameters: RequestParameters {
        return [:]
    }
}

// MARK: - RequestHeaders
extension APIDecodableResponseRequest {
    var headers: RequestHeaders {
        return [:]
    }
}
