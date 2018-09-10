//
//  Request.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/7/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol Request {
    
    associatedtype BaseResponse
    
    var headerFields : [String : String] { get }
    var params : [String : AnyObject] { get }
    var path : String { get }
    var timeout : TimeInterval { get }
    var method: HTTPMethod { get }
    
    func parseData(_ object: AnyObject, data : HTTPURLResponse) -> BaseResponse?
    
}

extension Request where BaseResponse : Mappable {
    func parseData(_ object: AnyObject, data : HTTPURLResponse) -> BaseResponse? {
        guard let model = Mapper<BaseResponse>().map(JSONObject: object) else {
            return nil
        }
        return model
    }
}
