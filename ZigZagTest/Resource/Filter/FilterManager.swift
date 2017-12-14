//
//  Constants.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit.UIColor

typealias Setter = (key: FilterManager.Category, value: Any)

struct FilterManager {
  static let shared = FilterManager()
  let identifier = "filter"
  
  enum Category: String {
    typealias Identity = String
    case age = "ages"
    case style = "styles"
    
    var val: String { return self.rawValue }
  }
  
  // Filter Environment
  func columns(_ type: Category) -> Int {
    switch type {
    case .age: return 4
    case .style: return 3
    }
  }
  
  func keyColor(_ type: Category) -> UIColor {
    switch type {
    case .age: return .black
    case .style: return .purple
    }
  }
  
  // Read And Write FilterSet
  func getFilter() -> Filter {
    if let data = UserDefaults.standard.object(forKey: identifier) as? [String: Any],
      let set = Filter(data: data) {
      return set
    } else {
      return Filter()
    }
  }
  
  func setFilter(_ filterSet: Filter) {
    UserDefaults.standard.set(filterSet.exposed, forKey: identifier)
  }
  
  func getRepresentativeAgesData(_ ages: [Int]) -> String {
    var res = [String?](repeating: "", count: 3)
    res[0] = ages[0] == 1 ? "10대" : nil
    res[1] = ages[1...3].flatMap {$0 == 1 ? 1 : nil}.count > 0 ? "20대" : nil
    res[2] = ages[4...6].flatMap {$0 == 1 ? 1 : nil}.count > 0 ? "30대" : nil
    return res.flatMap {$0}.joined(separator: " ")
  }
  
  // Filter Data
  let ages: [String] = [
    "10대",
    "20대 초반",
    "20대 중반",
    "20대 후반",
    "30대 초반",
    "30대 중반",
    "30대 후반"
  ]

  // bg for Background, bd for Border Color
  let styles: [String: (bg: UIColor, bd: UIColor)] = [
    "페미닌" : (bg: UIColor.Flat.Green.fern, bd: UIColor.darkGray),
    "모던시크" : (bg: UIColor.Flat.Green.mountain, bd: UIColor.darkGray),
    "심플베이직" : (bg: UIColor.Flat.Blue.picton, bd: UIColor.Flat.Blue.whale),
    "러블리" : (bg: UIColor.Flat.Blue.mariner, bd: UIColor.black),
    "유니크" : (bg: UIColor.Flat.Violet.wisteria, bd: UIColor.Flat.Violet.gem),
    "미시스타일" : (bg: UIColor.Flat.Blue.mariner, bd: UIColor.Flat.Blue.whale),
    "캠퍼스룩" : (bg: UIColor.Flat.Yellow.energy, bd: UIColor.Flat.Red.well),
    "빈티지" : (bg: UIColor.Flat.Orange.neon, bd: UIColor.Flat.Orange.sun),
    "섹시글램" : (bg: UIColor.Flat.Red.terra, bd: UIColor.Flat.Red.well),
    "스쿨룩" : (bg: UIColor.Flat.Yellow.turbo, bd: UIColor.red),
    "로맨틱" : (bg: UIColor.Flat.Gray.almond, bd: UIColor.darkGray),
    "오피스룩" : (bg: UIColor.Flat.Gray.smoke, bd: UIColor.lightGray),
    "럭셔리" : (bg: UIColor.Flat.Green.fern, bd: UIColor.Flat.Blue.denim),
    "헐리웃스타일" : (bg: UIColor.Flat.Blue.picton, bd: UIColor.Flat.Violet.gem)
  ]

}
