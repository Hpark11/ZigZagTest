//
//  ShoppingMallTableViewCell.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class ShoppingMallTableViewCell: UITableViewCell, NibLoadable {

  @IBOutlet weak var mRankLabel: UILabel!
  @IBOutlet weak var mShopImageView: DownloadableImageView!
  @IBOutlet weak var mShopNameLabel: UILabel!
  @IBOutlet weak var mAgeLabel: PaddedLabel!
  
  @IBOutlet weak var mFirstStyleLabel: PaddedLabel!
  @IBOutlet weak var mSecondStyleLabel: PaddedLabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureStyleLabel(name: String, label: PaddedLabel) {
    label.text = name
    label.layer.borderColor = FilterService.shared.styles[name]!.bd.cgColor
    label.textColor = FilterService.shared.styles[name]!.bd
    label.backgroundColor = FilterService.shared.styles[name]!.bg
  }
  
  func configure(shop: ShoppingMall, index: Int) {
    mRankLabel.text = "\(index + 1)"
    mShopNameLabel.text = shop.name
    mAgeLabel.text = FilterService.shared.getRepresentativeAgesData(shop.age)
    
    if let first = shop.style.first {configureStyleLabel(name: first, label: mFirstStyleLabel)}
    if let second = shop.style.last {configureStyleLabel(name: second, label: mSecondStyleLabel)}
  
    let pattern = "(http:\\/\\/www.|www.|http:\\/\\/)([\\w-]+)([\\.\\w\\/]+)"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let replacedStr = regex.stringByReplacingMatches(in: shop.url, options: [],
                                                     range: NSRange(location: 0, length: shop.url.count),
                                                     withTemplate: "$2")
    
    mShopImageView.imageUrl = "https://cf.shop.s.zigzag.kr/images/\(replacedStr).jpg"
  }
  
  override func awakeFromNib() {
    mShopImageView.layer.cornerRadius = mShopImageView.frame.height / 2
    mShopImageView.clipsToBounds = true
  }
  
  override func prepareForReuse() {
    mShopImageView.session.invalidateAndCancel()
    super.prepareForReuse()
  }
}
