//
//  RequestProtocol.swift
//  Fodamy
//
//  Created by İbrahim Kültepe on 26.02.2023.
//

protocol RequestProtocol {
   var path: String { get }
   var method: RequestMethod { get }
   var parameters: RequestParameters { get }
   var headers: RequestHeaders { get }
   var encoding: RequestEncoding { get }
   var url: String { get }
}
