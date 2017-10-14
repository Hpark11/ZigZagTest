//
//  ShoppingMallTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class ShoppingMallTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var rankLabel: UILabel!
  @IBOutlet weak var shopImageView: UIImageView!
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  @IBOutlet weak var styleStackView: UIStackView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configure() {
    
  }
}
