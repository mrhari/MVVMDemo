//
//  BaseResponse.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/7/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    
    var response : String? = ""
    var error : String? = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        response <- map["Response"]
        error <- map["Error"]
    }
    
    
}
