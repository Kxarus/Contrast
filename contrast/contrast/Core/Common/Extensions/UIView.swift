//
//  UIView.swift
//  contrast
//
//  Created by Roman Kiruxin on 15.07.2023.
//

import UIKit

extension UIView {
   func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
       let gradient = CAGradientLayer()
       gradient.frame = frame
       gradient.colors = colors.map{$0.cgColor}
       gradient.locations = [0.6, 1.0]
       self.layer.insertSublayer(gradient, at: 0)
   }
}
