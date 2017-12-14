//
//  StyleFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class StyleFilterTableViewCell: UITableViewCell, NibLoadable {

  let columns = 3
  let itemCount = FilterManager.shared.styles.count
  var filter: Filter?
  
  func configure(filter: Filter) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - (CGFloat(columns) + 1) * 8) / CGFloat(columns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    self.filter = filter
    
    FilterManager.shared.styles.enumerated().forEach { i, style in
      let button = RoundedButton(title: style.key, color: FilterManager.shared.keyColor(.style))
      contentView.addSubview(button)
      
      button.tag = i
      if let styles = filter.exposed[Filter.Key.style.val] as? [String] {
        button.isChecked = styles.contains(style.key) ? true : false
      }
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(googims), for: .touchUpInside)
      
      topAnchor = (button.tag + 1) % columns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % columns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
    
    self.contentView.anchor(heightConstant: CGFloat(itemCount / columns + 1) * (height + 8) + 8)
    self.contentView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  @objc func googims(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
    guard let filter = self.filter else { return }
    filter.setFilterComponents((key: .style, value: sender.titleLabel?.text))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
