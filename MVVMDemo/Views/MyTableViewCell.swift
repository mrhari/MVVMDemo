//
//  MyTableViewCell.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/5/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var yearView: UILabel!
    @IBOutlet weak var imdbView: UILabel!
    @IBOutlet weak var typeView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setViews(film : FilmModel) {
        titleView.text = "Title: " + film.title!
        yearView.text = "Year: " + film.year!
        imdbView.text = "imdb ID: " + film.imdbID!
        typeView.text = "Type: " + film.type!
                
//        Alamofire.request(film.Poster!).response { response in
//            guard let data = response.data
//                else {
//                    self.imgView.image = UIImage(named: "noimage")
//                    return
//                }
//            self.imgView.image = UIImage(data: data) ?? UIImage(named: "noimage")
//        }
        let url = URL(string: film.poster!)
        self.imgView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "noimage"), options: nil, progressBlock: nil, completionHandler: nil)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
