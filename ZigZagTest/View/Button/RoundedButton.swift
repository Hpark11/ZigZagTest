//
//  RoundedButton.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  public var isChecked: Bool = false {
    didSet {
      setSelectedState(isChecked)
    }
  }
  private var mColor: UIColor = .black
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  required init(title: String, color: UIColor) {
    mColor = color
    super.init(frame: .zero)
    
    backgroundColor = .white
    tintColor = mColor
    layer.borderColor = mColor.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = 8
    
    titleLabel?.font = UIFont.systemFont(ofSize: 16)
    titleLabel?.adjustsFontSizeToFitWidth = true
    setTitle(title, for: .normal)
    setTitleColor(mColor, for: .normal)
    isUserInteractionEnabled = true
  }
  
  private func setSelectedState(_ b: Bool) {
    backgroundColor = b ? mColor : UIColor.white
    tintColor = b ? mColor : UIColor.white
    setTitleColor(b ? .white : mColor, for: .normal)
  }
}

extension RoundedButton {
  convenience init(_ title: String, color: UIColor) {
    self.init(title: title, color: color)
  }
}
