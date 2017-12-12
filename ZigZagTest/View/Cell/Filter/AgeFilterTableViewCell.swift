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
  
  var marker = [Int](repeating: 0, count: Filter.shared.ages.count)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let width: CGFloat = (UIScreen.main.bounds.size.width - CGFloat((columns + 1) * 8)) / 4
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    for (i, title) in Filter.shared.ages.enumerated() {
      let button = RoundedButton(title: title, color: Filter.keyColor(.age))
      contentView.addSubview(button)
      
      button.tag = i
      _ = button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(googims), for: .touchUpInside)
      
      topAnchor = (button.tag + 1) % columns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % columns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
  }
  
  @objc func googims(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}
