//
//  PaddedLabel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 15..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

@IBDesignable
class PaddedLabel: UILabel {
  @IBInspectable var topInset: CGFloat = 0.0
  @IBInspectable var bottomInset: CGFloat = 0.0
  @IBInspectable var leftInset: CGFloat = 4.0
  @IBInspectable var rightInset: CGFloat = 4.0
  
  @IBInspectable var borderWidth: CGFloat = 0.4
  @IBInspectable var cornerRadius: CGFloat = 0
  @IBInspectable var borderColor: UIColor = .lightGray
  @IBInspectable var masksToBounds: Bool = true
  
  override func drawText(in rect: CGRect) {
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor.cgColor
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = masksToBounds
    
    let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override public var intrinsicContentSize: CGSize {
    var contentSize = super.intrinsicContentSize
    contentSize.height += topInset + bottomInset
    contentSize.width += leftInset + rightInset
    return contentSize
  }
}


