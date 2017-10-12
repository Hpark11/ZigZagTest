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
  
  lazy var subStackViews: ([String], Constants.FilterType) -> ([UIStackView]) = { queries, type in
    var stackViews: [UIStackView] = []
    let colForRow: Int = type.rawValue
    
    queries.enumerated().forEach { offset, value in
      let index = offset % colForRow
      if index == 0 {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        stackViews.append(stackView)
      }
      let button = RoundedButton(value, color: UIColor.black)
      stackViews.last!.insertArrangedSubview(button, at: index)
    }
  
    return stackViews
  }
  
  func configure(type: Constants.FilterType) {
    var stackViews = [UIStackView]()
    
    if type == .age {
      stackViews = subStackViews(Constants.ages, type)
    } else {
      stackViews = subStackViews(Constants.styles, type)
    }
    
    for (i, sub) in stackViews.enumerated() {
      mainStackView.insertArrangedSubview(sub, at: i)
    }
  }
  
  override func awakeFromNib() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
