//
//  FilterItemButton.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 18..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

@IBDesignable
class FilterItemButton: UIButton {

//  backgroundColor = .white
//  tintColor = self.color
//  layer.borderColor = self.color.cgColor
//  layer.borderWidth = 1.0
//  layer.cornerRadius = 8
  
  @IBInspectable var borderColor: UIColor = .black
  @IBInspectable var borderWidth: CGFloat = 1.0
  @IBInspectable var cornerRadius: CGFloat = 8
  @IBInspectable var maskToBounds: Bool = true
  
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    layer.borderColor = borderColor.cgColor
    layer.borderWidth = borderWidth
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
    super.draw(rect)
  }
  


}
