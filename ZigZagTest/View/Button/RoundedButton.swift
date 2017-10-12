//
//  RoundedButton.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  private var color: UIColor = .black
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  required init(title: String, color: UIColor) {
    self.color = color
    super.init(frame: .zero)
    
    backgroundColor = .white
    self.tintColor = self.color
    self.layer.borderColor = self.color.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 8
    self.setTitle(title, for: .normal)
  }
  
  public func setSelectedState(_ b: Bool) {
    if b == true {
      self.backgroundColor = self.color
      self.tintColor = self.color
    } else {
      self.backgroundColor = UIColor.white
      self.tintColor = UIColor.white
    }
  }
}

extension RoundedButton {
  convenience init(_ title: String, color: UIColor) {
    self.init(title: title, color: color)
  }
}
