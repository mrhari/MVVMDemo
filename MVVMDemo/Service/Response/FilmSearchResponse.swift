//
//  FilmSearchResponse.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/8/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

class FilmSearchResponse : BaseResponse {
    
    var searchResult : [FilmModel] = []
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        searchResult <- map["Search"]
    }
}
