//
//  PaddedLabel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 15..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 4)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
}

