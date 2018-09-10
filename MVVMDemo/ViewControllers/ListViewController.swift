//
//  ListViewController.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/4/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgView: UILabel!
    @IBAction func onBack(segue: UIStoryboardSegue) {}
    
    let disposeBag = DisposeBag()
    let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        let cell = UINib(nibName: "MyTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "MyTableViewCell")
        tableView.separatorColor = .gray
        
        searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter {!$0.isEmpty}
            .subscribe(onNext: { query in
                self.searchViewModel.searchFilm(textSearch: query)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        searchViewModel.msgError
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { msg in
                self.msgView.isHidden = msg.isEmpty
                self.msgView.text = msg
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        searchViewModel.resultSearch
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tableView.reloadData()
                if data.count > 0 {
                    let index = IndexPath(item: 0, section: 0)
                    self.tableView.scrollToRow(at: index, at: UITableViewScrollPosition.top, animated: false)
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.getCountItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.setViews(film: searchViewModel.getDataForItem(indexPath: indexPath))
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
