//
//  Constants.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit.UIColor

typealias FilterKey = FilterService.Category

final class FilterService {
  static let shared = FilterService()
  let identifier = "filter"

  var conditionsByAges: [Int]
  var conditionsByStyles: [String]
  
  enum Category: String {
    typealias Identity = String
    case age = "ages"
    case style = "styles"
    
    var val: String { return self.rawValue }
    var columns: Int {
      switch self {
      case .age:
        return 4
      case .style:
        return 3
      }
    }
    
    var keyColor: UIColor {
      switch self {
      case .age:
        return .black
      case .style:
        return .purple
      }
    }
  }
  
  // Filter Data
  let AGES: [String] = [
    "10대",
    "20대 초반",
    "20대 중반",
    "20대 후반",
    "30대 초반",
    "30대 중반",
    "30대 후반"
  ]
  
  // bg for Background, bd for Border Color
  let STYLES: [String: (bg: UIColor, bd: UIColor)] = [
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
  
  init() {
    if let ages = UserDefaults.standard.array(forKey: FilterKey.age.val) as? [Int] {
      conditionsByAges = ages
    } else {
      conditionsByAges = [Int](repeating: 0, count: AGES.count)
    }
    
    if let styles = UserDefaults.standard.array(forKey: FilterKey.style.val) as? [String] {
      conditionsByStyles = styles
    } else {
      conditionsByStyles = [String]()
    }
  }
  
  private func filterByAges(_ mall: ShoppingMall) -> Bool {
    for (i, e) in conditionsByAges.enumerated() {
      if mall.age[i] == e && e == 1 {
        return true
      }
    }
    return false
  }
  
  private func filterByStyles(_ mall: ShoppingMall) -> Bool {
    for s in conditionsByStyles {
      if mall.style.contains(s) {
        return true
      }
    }
    return false
  }
  
  private func numberOfStyleMatches(_ styles: [String]) -> Int {
    return styles.reduce(0) {self.conditionsByStyles.contains($1) ? $0 + 1 : $0}
  }
  
  func filteredMalls(malls: [ShoppingMall]) -> [ShoppingMall] {
    let result: [ShoppingMall]
    
    switch (!conditionsByAges.contains(1), conditionsByStyles.count == 0) {
    case (true, true):
      result = malls
      break
    case (true, false):
      result = malls.filter(filterByStyles)
      break
    case (false, true):
      result = malls.filter(filterByAges)
      break
    default:
      result = malls.filter(filterByAges).filter(filterByStyles)
      break
    }
    
    return result.sorted { lhs, rhs in
      if numberOfStyleMatches(lhs.style) == numberOfStyleMatches(rhs.style) {
        return lhs.score > rhs.score
      } else {
        return numberOfStyleMatches(lhs.style) > numberOfStyleMatches(rhs.style)
      }
    }
  }
  
  func setFilter(ages: [Int], styles: [String]) {
    conditionsByAges = ages
    conditionsByStyles = styles
    
    UserDefaults.standard.set(ages, forKey: FilterKey.age.val)
    UserDefaults.standard.set(styles, forKey: FilterKey.style.val)
  }
  
  func getRepresentativeAgesData(_ ages: [Int]) -> String {
    var res = [String?](repeating: "", count: 3)
    res[0] = ages[0] == 1 ? "10대" : nil
    res[1] = ages[1...3].flatMap {$0 == 1 ? 1 : nil}.count > 0 ? "20대" : nil
    res[2] = ages[4...6].flatMap {$0 == 1 ? 1 : nil}.count > 0 ? "30대" : nil
    return res.flatMap {$0}.joined(separator: " ")
  }
}
