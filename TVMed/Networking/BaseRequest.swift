//
//  BaseRequest.swift
//  Zazcar
//
//  Created by Vinicius Albino on 12/01/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

public typealias JSONDictionary = [String: Any]

typealias DefaultCallBackClosure = (AnyObject?, ErrorTypeApp?, URLResponse?) -> ()

protocol DefaultRequest {
    func makeRequest(parameters: [String: AnyObject], callback: @escaping DefaultCallBackClosure)
}

protocol BaseRequestHeaders {
    func headers() -> [String: String]
}

class TVMedBaseRequestHeaders: BaseRequestHeaders {
    func headers() -> [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
    }
}

enum HttpProtocol: String {
    case HTTP = "http://"
    case HTTPS = "https://"
}

enum HttpAction: String {
    case GET = "GET"
    case POST = "POST"
}


let domain = "https://webplayer.tvmed.com.br/api/"

func defaultDomain() -> String {
    return domain
}

class BaseRequest: NSObject {
    
    func GET(url: String, params: JSONDictionary?, headers: [String: String], callback: @escaping DefaultCallBackClosure) {
        let finalURL = "\(domain)\(url)"
        Alamofire.request(finalURL, method: .get, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            guard let _ = response.result.value else {
                callback(nil, .apiError, response.response)
                return
            }
            
            if let result = response.result.value {
                callback(result as AnyObject?, nil, response.response)
            }
        }
    }
    
    func POST(url: String, params: JSONDictionary?, headers: [String: String], callback: @escaping DefaultCallBackClosure) {
        let finalURL = "\(domain)\(url)"
        Alamofire.request(finalURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let _ = response.result.value else {
                callback(nil, .apiError, response.response)
                return
            }
            if let result = response.result.value {
                callback(result as AnyObject?, nil, response.response)
            }
        }
    }
    
    func PUT(url: String, params: JSONDictionary?, headers: [String: String], callback: @escaping DefaultCallBackClosure) {
        let finalURL = "\(domain)\(url)"
        Alamofire.request(finalURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard let _ = response.result.value else {
                callback(nil, .apiError, response.response)
                return
            }
            if let result = response.result.value {
                callback(result as AnyObject?, nil, response.response)
            }
        }
    }
}
