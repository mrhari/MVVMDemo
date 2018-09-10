//
//  FilmModel.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/5/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import ObjectMapper

struct FilmModel : Mappable {
    
    init() {
        self.title = ""
        self.year = ""
        self.imdbID = ""
        self.type = ""
        self.poster = ""
    }
    
    init?(map: Map) {
        
    }
    
    
    var title : String?
    var year : String?
    var imdbID : String?
    var type : String?
    var poster : String?
    
    
    mutating func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        imdbID <- map["imdbID"]
        type <- map["Type"]
        poster <- map["Poster"]
    }
}
/*
 struct FilmResponse : Decodable {
 
 var Search : [FilmModel]?
 let Response : String?
 let Error : String?
 
 //    init(response: String?, error: String?) {
 //        self.Response = response
 //        self.Error = error
 //    }
 }*/
