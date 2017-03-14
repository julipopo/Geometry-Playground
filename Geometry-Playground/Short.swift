//
//  Short.swift
//  AboutMe
//
//  Created by Julien Simmer  on 18/11/2016.
//  Copyright © 2016 Julien Simmer . All rights reserved.
//

import CoreFoundation
import Foundation
import UIKit

func degreesToRadiant(degrees : CGFloat)->CGFloat{
    return (CGFloat(M_PI) * degrees)/180
}

func updateConstraint(name : String, inView : UIView, newValue: CGFloat){
    for constraint in inView.constraints as [NSLayoutConstraint] {
        if constraint.identifier == name {
            constraint.constant = newValue
            UIView.animate(withDuration: 0.5, animations: {
                inView.layoutIfNeeded()
            })
        }
    }
}

extension UIView {
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
