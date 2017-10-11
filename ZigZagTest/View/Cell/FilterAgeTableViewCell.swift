//
//  FilterAgeTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterAgeTableViewCell: UITableViewCell {

  @IBOutlet weak var mainStackView: UIStackView!
  
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    Constants.Ages.count
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
