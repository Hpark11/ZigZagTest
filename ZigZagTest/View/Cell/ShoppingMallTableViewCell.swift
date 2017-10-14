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
  @IBOutlet weak var shopImageView: DownloadableImageView!
  @IBOutlet weak var shopNameLabel: UILabel!
  @IBOutlet weak var ageLabel: PaddedLabel!
  @IBOutlet weak var styleStackView: UIStackView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func configure(shop: ShoppingMall, index: Int) {
    rankLabel.text = "\(index + 1)"
    shopNameLabel.text = shop.name
    ageLabel.text = Filter.getRepresentativeAgesData(shop.age)
    ageLabel.frame.size.width = ageLabel.frame.width + 8
    
    styleStackView.arrangedSubviews.enumerated().forEach { offset, views in
      guard let label = views as? UILabel, shop.style.count > offset else { return }
      label.text = shop.style[offset]
    }

    let pattern = "(http:\\/\\/www.|www.|http:\\/\\/)([\\w-]+)([\\.\\w\\/]+)"
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let replacedStr = regex.stringByReplacingMatches(in: shop.url, options: [],
                                                     range: NSRange(location: 0, length: shop.url.characters.count),
                                                     withTemplate: "$2")
    
    shopImageView.imageUrl = "https://cf.shop.s.zigzag.kr/images/\(replacedStr).jpg"
  }
  
  override func awakeFromNib() {
    shopImageView.layer.masksToBounds = false
    shopImageView.layer.cornerRadius = shopImageView.frame.height / 2
    shopImageView.clipsToBounds = true
    
    ageLabel.layer.borderColor = UIColor.lightGray.cgColor
    ageLabel.layer.cornerRadius = 4
    ageLabel.layer.borderWidth = 0.4
  }
  
  override func prepareForReuse() {
    shopImageView.image = nil
    super.prepareForReuse()
  }
}
