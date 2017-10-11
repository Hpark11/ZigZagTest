//
//  Constants.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

struct Constants {
  enum Ages: Int {
    case teenager = 0
    case twentyEarly
    case twentyMid
    case twentyLate
    case thirtyEarly
    case thirtyMid
    case thirtyLate
    
    static var count: Int { return Ages.thirtyLate.hashValue + 1 }
  }
  
  enum Styles: String {
    case famine = "페미닌"
    case modernCynical = "모던시크"
    case simpleBasic = "심플베이직"
    case lovely = "러블리"
    case unique = "유니크"
    case missiStyle = "미시스타일"
    case campusLook = "캠퍼스룩"
    case vintage = "빈티지"
    case sexyGlam = "섹시글램"
    case schoolLook = "스쿨룩"
    case romantic = "로맨틱"
    case officeLook = "오피스룩"
    case luxury = "럭셔리"
    case hollywoodStyle = "헐리웃스타일"
    
    static var count: Int { return Styles.hollywoodStyle.hashValue + 1 }
  }
}
