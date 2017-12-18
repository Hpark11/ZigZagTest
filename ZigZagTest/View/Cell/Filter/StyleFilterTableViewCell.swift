//
//  StyleFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class StyleFilterTableViewCell: UITableViewCell, NibLoadable {

  let columns = FilterService.shared.columns(.style)
  let itemCount = FilterService.shared.styles.count
  
  var mCheckFilter: ((RoundedButton) -> ())!
  
  func configure(conditions: [String], check: @escaping (RoundedButton) -> ()) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - (CGFloat(columns) + 1) * 8) / CGFloat(columns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    mCheckFilter = check
    
    FilterService.shared.styles.enumerated().forEach { i, style in
      let button = RoundedButton(title: style.key, color: FilterService.shared.keyColor(.style))
      contentView.addSubview(button)
      
      button.tag = i
      button.isChecked = conditions.contains(style.key) ? true : false
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(onStyleButtonTapped), for: .touchUpInside)
      topAnchor = (button.tag + 1) % columns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % columns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
    
    self.contentView.anchor(heightConstant: CGFloat(itemCount / columns + 1) * (height + 8) + 8)
    self.contentView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

@objc extension StyleFilterTableViewCell {
  func onStyleButtonTapped(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
    mCheckFilter(sender)
  }
}
