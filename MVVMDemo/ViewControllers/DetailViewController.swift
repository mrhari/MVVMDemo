//
//  DetailViewController.swift
//  MVVMDemo
//
//  Created by Ngo Van Hai on 9/9/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var urlImage = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromRight
//        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
//        view.window!.layer.add(transition, forKey: kCATransition)
        
        let url = URL(string: urlImage)
        imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "apple-swift"), options: nil, progressBlock: nil, completionHandler: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func swipeAction(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
