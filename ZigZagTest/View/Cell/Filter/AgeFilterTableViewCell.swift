//
//  AgeFilterTableViewCell.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class AgeFilterTableViewCell: UITableViewCell, NibLoadable {

  // 상수형태 최대한 avoid
  let columns = 4
  
  let itemCount = FilterManager.shared.ages.count
  
  // 왜 optional 썼는지 혹은 사용 목적이나 의도 더욱 분명히 파악해서 수정
  var filter: Filter?
  
  func configure(filter: Filter) {
    let width: CGFloat = (UIScreen.main.bounds.size.width - CGFloat((columns + 1) * 8)) / CGFloat(columns)
    let height: CGFloat = 32
    
    var topAnchor: NSLayoutYAxisAnchor = contentView.topAnchor
    var leftAnchor: NSLayoutXAxisAnchor = contentView.leftAnchor
    
    self.filter = filter
    
    FilterManager.shared.ages.enumerated().forEach { i, title in
      let button = RoundedButton(title: title, color: FilterManager.shared.keyColor(.age))
      contentView.addSubview(button)
      
      button.tag = i
      if let ages = filter.exposed[Filter.Key.age.val] as? [Int] {
        button.isChecked = ages[i] == 1
      }
      button.anchor(topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: width, heightConstant: height)
      button.addTarget(self, action: #selector(googims), for: .touchUpInside)
      
      topAnchor = (button.tag + 1) % columns == 0 ? button.bottomAnchor : topAnchor
      leftAnchor = (button.tag + 1) % columns == 0 ? contentView.leftAnchor : button.rightAnchor
    }
    
    contentView.anchor(heightConstant: CGFloat(itemCount / columns + 1) * (height + 8) + 8)
    contentView.translatesAutoresizingMaskIntoConstraints = true
  }
  
  // 이름 바꾸라
  // selector에 대해서 좀더 확인 요망
  @objc func googims(_ sender: RoundedButton) {
    sender.isChecked = !sender.isChecked
    guard let filter = self.filter else { return }
    filter.setFilterComponents((key: .age, value: sender.tag))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
