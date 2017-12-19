//
//  StyleFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class StyleFilterTableViewCell: UITableViewCell, NibLoadable {

  private let mColumns = FilterService.Category.style.columns
  private let mItemCount = FilterService.shared.STYLES.count
  
  private var mCheckFilter: ((RoundedButton) -> ())!
  
  func configure(conditions: [String], check: @escaping (RoundedButton) -> ()) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - (CGFloat(mColumns) + 1) * 8) / CGFloat(mColumns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    mCheckFilter = check
    
    FilterService.shared.STYLES.enumerated().forEach { i, style in
      let button = RoundedButton(title: style.key, color: FilterService.Category.style.keyColor)
      contentView.addSubview(button)
      
      button.tag = i
      button.isChecked = conditions.contains(style.key)
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(onStyleButtonTapped), for: .touchUpInside)
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

@objc extension StyleFilterTableViewCell {
  func onStyleButtonTapped(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
    mCheckFilter(sender)
  }
}
