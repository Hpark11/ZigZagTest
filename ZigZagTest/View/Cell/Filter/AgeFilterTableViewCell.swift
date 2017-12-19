//
//  AgeFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit


class AgeFilterTableViewCell: UITableViewCell, NibLoadable {

  let columns = FilterService.shared.columns(.age)
  let itemCount = FilterService.shared.ages.count
  
  var mCheckFilter: ((RoundedButton) -> ())!
  
  func configure(conditions: [Int], check: @escaping (RoundedButton) -> ()) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - CGFloat((columns + 1) * 8)) / CGFloat(columns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    mCheckFilter = check
    
    FilterService.shared.ages.enumerated().forEach { i, title in
      let button = RoundedButton(title: title, color: FilterService.shared.keyColor(.age))
      contentView.addSubview(button)
      
      button.tag = i
      button.isChecked = conditions[i] == 1
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(onAgeFilterButtonTapped), for: .touchUpInside)
      
      topAnchor = (button.tag + 1) % columns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % columns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
    
    contentView.anchor(heightConstant: CGFloat(itemCount / columns + 1) * (height + 8) + 8)
    contentView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

@objc extension AgeFilterTableViewCell {
  func onAgeFilterButtonTapped(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
    mCheckFilter(sender)
  }
}
