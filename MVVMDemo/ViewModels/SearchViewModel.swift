//
//  SearchViewModel.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/5/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

struct SearchViewModel {
    let urlSearch : String = "http://www.omdbapi.com/?apikey=2ae3901e&s="
    let alamofire = Alamofire.SessionManager.default
    var msgError = Variable<String>("No Data")
    var resultSearch = Variable<[FilmModel]>([])
    
    init() {
    }
    
    func getCountItems() -> Int{
        return resultSearch.value.isEmpty ? 0 : resultSearch.value.count
    }
    
    func getDataForItem(indexPath: IndexPath) -> FilmModel{
        if indexPath.row >= resultSearch.value.count {
            return FilmModel()
        }
        return resultSearch.value[indexPath.row]
    }
    
    func searchFilm(textSearch : String) {
        cancelRequest()
        let request = SearchFilmRequest(query: textSearch)
        _ = APIClient.rx_request(request: request).subscribe(onNext: { response in
            if response.response == "False" {
                self.msgError.value = response.error!
                self.resultSearch.value.removeAll()
            }
            if response.response == "True" {
                self.msgError.value = ""
                self.resultSearch.value = response.searchResult
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
    
    private func cancelRequest() {
        alamofire.session.getAllTasks(completionHandler: { task in
            task.forEach({
                $0.cancel()
                print("cancel request")
            })
        })
    }
}

