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
  private var color: UIColor = .black
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  required init(title: String, color: UIColor) {
    self.color = color
    super.init(frame: .zero)
    
    backgroundColor = .white
    tintColor = self.color
    layer.borderColor = self.color.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = 8
    
    titleLabel?.font = UIFont.systemFont(ofSize: 16)
    titleLabel?.adjustsFontSizeToFitWidth = true
    setTitle(title, for: .normal)
    setTitleColor(self.color, for: .normal)
    isUserInteractionEnabled = true
  }
  
  private func setSelectedState(_ b: Bool) {
    backgroundColor = b == true ? color : UIColor.white
    tintColor = b == true ? color : UIColor.white
    setTitleColor(b == true ? .white : color, for: .normal)
  }
}

extension RoundedButton {
  convenience init(_ title: String, color: UIColor) {
    self.init(title: title, color: color)
  }
}
