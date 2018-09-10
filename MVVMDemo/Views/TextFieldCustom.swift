//
//  TextFieldCustom.swift
//  Fax2
//
//  Created by Ngo Van Hai on 8/30/18.
//  Copyright © 2018 Ngo Van Hai. All rights reserved.
//

import UIKit

class TextFieldCustom: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var textfieldView: UITextField!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var lineBelow: UIView!
    @IBOutlet weak var constrainHeight: NSLayoutConstraint!
    @IBInspectable
    public var placeHolder : String = "Default" {
        didSet{
            labelView.text = placeHolder
        }
    }
    @IBInspectable
    public var spaceX : Float = 0.0
    
    @IBInspectable
    public var leftIcon : UIImage?
    
    @IBInspectable
    public var isPasswordType : Bool = false
    
    var isFocusTextField: Bool = false
    open var text : String? {
        return textfieldView.text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setViewsFromXib()
    }
    
    override func awakeFromNib() {
        //let widthImg = imgLeft.frame.width
        if leftIcon != nil{
            imgLeft.image = leftIcon
        } else {
            imgLeft.backgroundColor = UIColor.red
            for constraint in imgLeft.constraints{
                if(constraint.identifier == "heightImg"){
                    constraint.isActive = false
                }
            }
            //imgLeft.frame = CGRect(x: imgLeft.frame.origin.x, y: imgLeft.frame.origin.y, width: 10, height: imgLeft.frame.height)
        }
        textfieldView.isSecureTextEntry = isPasswordType
        self.textfieldView.delegate = self
        
    }
    
    func setViewsFromXib(){
        let bundle = Bundle.init(for : type(of : self))
        let nib = UINib(nibName: "TextFieldCustom", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        addSubview(view)
        view.frame = self.bounds
        //textfieldView.backgroundColor = UIColor.brown
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if !isFocusTextField {
            isFocusTextField = true
            lineBelow.backgroundColor = UIColor.red
            if (textfieldView.text?.isEmpty != true){
                return
            }
            animateFocus(view: labelView, spaceX: spaceX)
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if isFocusTextField {
            isFocusTextField = false
            lineBelow.backgroundColor = UIColor.gray
            if (textfieldView.text?.isEmpty != true){
                return
            }
            animateUnFocus(view: labelView, spaceX: spaceX)
        }
        
    }
    
    func animateFocus(view : UILabel, spaceX : Float){
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            var myTranform = view.transform.scaledBy(x: 0.8, y: 0.8)
            let space : Float = -1.0 * spaceX
            myTranform = myTranform.translatedBy(x: CGFloat(space), y: -30)
            view.transform = myTranform
        })
    }
    
    func animateUnFocus(view : UILabel, spaceX : Float){
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            var myTranform = view.transform.translatedBy(x: CGFloat(spaceX), y: 30)
            myTranform = myTranform.scaledBy(x: 1.25, y: 1.25)
            view.transform = myTranform
        })
    }
    
}
