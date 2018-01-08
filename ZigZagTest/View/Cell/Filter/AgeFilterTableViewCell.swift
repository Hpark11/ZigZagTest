//
//  AgeFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit


class AgeFilterTableViewCell: UITableViewCell, NibLoadable {
  private let mColumns = FilterService.Category.age.columns
  private let mItemCount = FilterService.shared.AGES.count
  
  private var mCheckFilter: ((RoundedButton) -> ())!
  
  func configure(conditions: [Int], check: @escaping (RoundedButton) -> ()) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - CGFloat((mColumns + 1) * 8)) / CGFloat(mColumns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    mCheckFilter = check
    
    FilterService.shared.AGES.enumerated().forEach { i, title in
      let button = RoundedButton(title: title, color: FilterService.Category.age.keyColor)
      contentView.addSubview(button)
      
      button.tag = i
      button.isChecked = conditions[i] == 1
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(onAgeFilterButtonTapped), for: .touchUpInside)
      topAnchor = (button.tag + 1) % mColumns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % mColumns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
    
    contentView.anchor(heightConstant: CGFloat(mItemCount / mColumns + 1) * (height + 8) + 8)
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
