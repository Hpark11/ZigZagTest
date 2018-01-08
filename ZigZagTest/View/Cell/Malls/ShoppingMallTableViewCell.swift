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
  
  var borderColor = UIColor.white.cgColor
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configureStyleLabel(name: String, label: PaddedLabel) {
    label.text = name
    
    borderColor = FilterService.shared.STYLES[name]!.bd.cgColor
    
    label.layer.borderColor = borderColor
    label.textColor = FilterService.shared.STYLES[name]!.bd
    label.backgroundColor = FilterService.shared.STYLES[name]!.bg
  }
  
  func configure(shop: ShoppingMall, index: Int) {
    mRankLabel.text = "\(index + 1)"
    mShopNameLabel.text = shop.name
    mAgeLabel.text = FilterService.shared.getRepresentativeAgesData(shop.age)
    
    if let first = shop.style.first, let second = shop.style.last {
      configureStyleLabel(name: first, label: mFirstStyleLabel)
      configureStyleLabel(name: second, label: mSecondStyleLabel)
    }
  
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
    mShopImageView.cancelImageLoaderTask()
    super.prepareForReuse()
  }
}
