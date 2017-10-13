//
//  RoundedButton.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  private var isChecked: Bool?
  private var color: UIColor = .black
  override var isSelected: Bool {
    didSet {
      setSelectedState(isSelected)
    }
  }
  
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
    
    self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    self.titleLabel?.adjustsFontSizeToFitWidth = true
    self.setTitle(title, for: .normal)
    self.setTitleColor(self.color, for: .normal)
    self.isUserInteractionEnabled = true
  }
  
  private func setSelectedState(_ b: Bool) {
    if b == true {
      self.backgroundColor = self.color
      self.tintColor = self.color
      self.setTitleColor(.white, for: .normal)
    } else {
      self.backgroundColor = UIColor.white
      self.tintColor = UIColor.white
      self.setTitleColor(self.color, for: .normal)
    }
  }
}

extension RoundedButton {
  convenience init(_ title: String, color: UIColor) {
    self.init(title: title, color: color)
  }
}
