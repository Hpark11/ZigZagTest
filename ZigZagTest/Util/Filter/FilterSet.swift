//
//  Filtered.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 13..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

struct FilterSet {
  enum Key: String {
    case all = "filter"
    case ages = "ages"
    case styles = "styles"
    
    var val: String {
      return self.rawValue
    }
  }
  
  private var ages: [Int]
  private var styles: Set<String>
  
  private init(ages: [Int], styles: Set<String>) {
    self.ages = ages
    self.styles = styles
  }
  
  init?(data: [String: Any]) {
    guard let ages = data[Key.ages.val] as? [Int],
      let styles = data[Key.styles.val] as? [String] else { return nil }
    self.init(ages: ages, styles: Set(styles))
  }
  
  init() {
    self.ages = Array(repeating: 0, count: Filter.ages.count)
    self.styles = ["안녕하세요"]
  }
  
  public var exposed: [String: Any] {
    return [Key.ages.val: ages, Key.styles.val: Array(styles)]
  }
  
  public func set(_ key: Key, value: Any) {
    switch key {
    case .ages: setAgeFilter(value as! Int)
    case .styles: setStyleFilter(value as! String)
    default: break
    }
  }
  
  public mutating func setAgeFilter(_ index: Int) {
    ages[index] = ages[index] == 1 ? 0 : 1
  }
  
  public mutating func setStyleFilter(_ style: String) {
    if styles.contains(style) {
      styles.insert(style)
    } else {
      styles.remove(style)
    }
  }
  
}
