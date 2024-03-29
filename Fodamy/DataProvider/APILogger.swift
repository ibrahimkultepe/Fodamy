//
//  APILogger.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

import Alamofire

final class APILogger: EventMonitor {
    
    static let shared = APILogger()
    
    let queue = DispatchQueue(label: "com.ibrahimkultepe.spaceX")
    
    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        print("---> Request Created <---")
        print(request.description)
    }
    
    func requestDidFinish(_ request: Request) {
        print("---> Request Finished <---")
        print(request.description)
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("---> Request JSONResponse <---")
        if let data = response.data, let json = String(data: data, encoding: .utf8) {
            print(json)
        }
    }
}
