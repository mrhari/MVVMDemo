//
//  SearchFilmRequest.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/8/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SearchFilmRequest: Request {
    
    init(query: String) {
        self.query = query
    }
    
    typealias BaseResponse = FilmSearchResponse
    
    var query: String
    
    var headerFields: [String : String] {
        return [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: [String : AnyObject] {
        return [:]
    }
    
    var path: String {
        return "?apikey=\(AppConstant.ApiKey)&s=" + query
    }
    
    var timeout: TimeInterval {
        return 10
    }
  
}
