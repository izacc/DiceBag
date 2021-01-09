//
//  Animations.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 11/25/20.
//

import Foundation
import UIKit

class Animations{
    
    //Shake animation
    static func shake(on view: UIView){
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.05
        
        animation.repeatCount = 4
        
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        
        view.layer.add(animation, forKey: "shake")
        
        
    }
}
