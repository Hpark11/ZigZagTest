//
//  FilterAgeTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit
import Action
import RxSwift
import RxCocoa

class FilterTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var mainStackView: UIStackView!
  
  var disposedBag = DisposeBag()
  
  lazy var subStackViews: (Filter.Category, Action<Setter, Void>, [String: Any]) -> ([UIStackView]) =
    { type, action, filterSet in
    var stackViews: [UIStackView] = []
    let colForRow: Int = Filter.rows(type)
    
    Filter.list(type).enumerated().forEach { offset, title in
      let index = offset % colForRow
      if index == 0 {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        stackViews.append(stackView)
      }
      
      let value: Any
      var button = RoundedButton(title, color: Filter.keyColor(type))
      
      switch type {
      case .age:
        value = offset
        if let ages = filterSet[type.val] as? [Int] { button.isChecked = ages[offset] == 1 ? true : false }
      case .style:
        value = title
        if let styles = filterSet[type.val] as? [String] { button.isChecked = styles.contains(title) ? true : false }
      }
      
      button.rx.bind(to: action) { btn in
        btn.isChecked = !btn.isChecked
        return (key: type, value: value)
      }
      stackViews.last!.insertArrangedSubview(button, at: index)
    }
    return stackViews
  }
  
  func configure(type: Filter.Category, update: Action<Setter, Void>, set: [String: Any]) {
    let stackViews = subStackViews(type, update, set)
    for (i, sub) in stackViews.enumerated() {
      mainStackView.insertArrangedSubview(sub, at: i)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareForReuse() {
    mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    disposedBag = DisposeBag()
    super.prepareForReuse()
  }
}
