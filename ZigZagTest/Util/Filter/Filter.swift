//
//  Constants.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit.UIColor
import RxDataSources

struct Filter {
  static let identifier = "filter"
  
  enum Category: String, IdentifiableType {
    typealias Identity = String
    case age = "ages"
    case style = "styles"
    
    var val: String { return self.rawValue }
    var identity: String { return "filter" }
  }
  
  static func rows(_ type: Category) -> Int {
    switch type {
    case .age: return 4
    case .style: return 3
    }
  }
  
  static func list(_ type: Category) -> [String] {
    switch type {
    case .age: return ages
    case .style: return styles
    }
  }
  
  static func keyColor(_ type: Category) -> UIColor {
    switch type {
    case .age: return .black
    case .style: return .purple
    }
  }
  
  static let ages: [String] = [
    "10대",
    "20대 초반",
    "20대 중반",
    "20대 후반",
    "30대 초반",
    "30대 중반",
    "30대 후반"
  ]

  static let styles: [String] = [
    "페미닌",
    "모던시크",
    "심플베이직",
    "러블리",
    "유니크",
    "미시스타일",
    "캠퍼스룩",
    "빈티지",
    "섹시글램",
    "스쿨룩",
    "로맨틱",
    "오피스룩",
    "럭셔리",
    "헐리웃스타일"
  ]

}
