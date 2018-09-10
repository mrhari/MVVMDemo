//
//  APIClient.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/7/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


public enum APIError : Error {
    case connectionError
    case parseError
    case invalidResponse
}

struct APIClient {
    
    
    public static func rx_request<T : Request>(request: T) -> Observable<T.BaseResponse> {
        
        let url = AppConstant.BaseUrl
        var urlRequest = URLRequest(url: URL(string: url + request.path)!)
        
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headerFields
        urlRequest.httpBody = Utils.convertParameterToData(request.params)
        urlRequest.timeoutInterval = request.timeout
        
        return Observable.create({ observer in
            Alamofire.request(urlRequest).responseJSON(completionHandler: { response in
                
                if let error = response.result.error {
                    observer.onError(error)
                    // handler error
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let object = response.result.value, let json = response.response {
                    guard let model = request.parseData(object as AnyObject, data: json) else {
                        observer.onError(APIError.parseError)
                        // handler error
                        return
                    }
                    observer.onNext(model)
                    observer.onCompleted()
                } else {
                    observer.onError(APIError.invalidResponse)
                    // handler error
                }
            })
            return Disposables.create {}
            
        })
        
    }
}
