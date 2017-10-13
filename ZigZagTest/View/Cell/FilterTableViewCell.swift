//
//  FilterAgeTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var mainStackView: UIStackView!
  
  lazy var subStackViews: (Filter.Category) -> ([UIStackView]) = { type in
    var stackViews: [UIStackView] = []
    let colForRow: Int = type.rawValue
    
    Filter.list(type).enumerated().forEach { offset, value in
      let index = offset % colForRow
      if index == 0 {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        stackViews.append(stackView)
      }
      let button = RoundedButton(value, color: Filter.keyColor(type))
      
      stackViews.last!.insertArrangedSubview(button, at: index)
    }
  
    return stackViews
  }
  
  func configure(type: Filter.Category) {
    let stackViews = subStackViews(type)
    for (i, sub) in stackViews.enumerated() {
      mainStackView.insertArrangedSubview(sub, at: i)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForReuse() {
    mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    super.prepareForReuse()
  }
}
