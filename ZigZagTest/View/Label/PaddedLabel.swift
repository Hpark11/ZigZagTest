//
//  PaddedLabel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 15..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
  var topInset: CGFloat = 0.0
  var bottomInset: CGFloat = 0.0
  var leftInset: CGFloat = 4.0
  var rightInset: CGFloat = 4.0
  
  override func drawText(in rect: CGRect) {
    self.layer.cornerRadius = 4
    self.layer.borderWidth = 0.4
    self.layer.masksToBounds = true
    let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override public var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += topInset + bottomInset
    contentSize.width += leftInset + rightInset
    return contentSize
  }
  
  func setPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat){
    self.topInset = top
    self.bottomInset = bottom
    self.leftInset = left
    self.rightInset = right
    let insets: UIEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    super.drawText(in: UIEdgeInsetsInsetRect(self.frame, insets))
  }
  
  func roundCorners(_ corner: UIRectCorner,_ radii: CGFloat) {
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.layer.bounds
    maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii)).cgPath
    
    self.layer.mask = maskLayer
    layer.masksToBounds = true
  }
}


