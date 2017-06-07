//
//  VideoRequest.swift
//  TVMed
//
//  Created by Vinicius de Moura Albino on 15/04/17.
//  Copyright © 2017 tvMed. All rights reserved.
//

import Foundation

class VideoRequest {
    
    func getDeviceToken(callback: @escaping (UDID?, ErrorTypeApp?) -> ()){
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().POST(url: "/video/device/uid", params: [:], headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                let result = result <*> (UDID.self, error)
                callback(result.object, result.error)
            })
        }
    }
    
    func createDeviceToken(dto: UIDDTO, callback: @escaping (UDID?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().POST(url: "/video/device/create", params: dto.parameters(), headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                let result = result <*> (UDID.self, error)
                callback(result.object, result.error)
            })
        }
    }
    
    func validateVideoToken(dto: VideoTokenDTO, callback: @escaping (VideoToken?, ErrorTypeApp?) -> ()) {
        HeaderBuilder().buildHeader { defaultHeaders in
            BaseRequest().POST(url: "/video/token", params: dto.parameters(), headers: defaultHeaders, callback: { result, error, response in
                guard error == nil else {
                    callback(nil, error)
                    return
                }
                let result = result <*> (VideoToken.self, error)
                callback(result.object, result.error)
            })
        }
    }
}
