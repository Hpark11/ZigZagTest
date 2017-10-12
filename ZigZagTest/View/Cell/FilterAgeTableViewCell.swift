//
//  FilterAgeTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterAgeTableViewCell: BaseTableViewCell {

  let colForRow: Int = 3
  
  @IBOutlet weak var mainStackView: UIStackView!
  
  lazy var subStackViews: [UIStackView] = {
    var stackViews: [UIStackView] = []
    
    Constants.ages.enumerated().forEach { offset, value in
      let index = offset % Constants.ages.count
      if index == 0 { stackViews.append(UIStackView()) }
      let button = RoundedButton(value, color: UIColor.black)
      stackViews.last!.insertArrangedSubview(button, at: index)
    }
  
    return stackViews
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    for (i, sub) in subStackViews.enumerated() {
      mainStackView.insertArrangedSubview(sub, at: i)
    }
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
