//
//  AgeFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class AgeFilterTableViewCell: UITableViewCell, NibLoadable {

  let columns = 4
  let itemCount = FilterManager.shared.ages.count
  var filter: Filter?
  
  func configure(filter: Filter) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - CGFloat((columns + 1) * 8)) / CGFloat(columns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    self.filter = filter
    
    FilterManager.shared.ages.enumerated().forEach { i, title in
      let button = RoundedButton(title: title, color: FilterManager.shared.keyColor(.age))
      contentView.addSubview(button)
      
      button.tag = i
      if let ages = filter.exposed[Filter.Key.age.val] as? [Int] { button.isChecked = ages[i] == 1 ? true : false }
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
    filter.setFilterComponents((key: .age, value: sender.tag))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}
