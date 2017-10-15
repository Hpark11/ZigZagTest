//
//  Filtered.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 13..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

class FilterSet {
  typealias Key = Filter.Category
  
  private var ages: [Int]
  private var styles: Set<String>
  
  public var exposed: [String: Any] {
    return [Key.age.val: ages,
            Key.style.val: Array(styles)]
  }
  
  public var isInitialized: Bool {
    return !ages.contains(1) && styles.count == 0
  }
  
  init() {
    self.ages = Array(repeating: 0, count: Filter.ages.count)
    self.styles = []
  }
  
  private init(ages: [Int], styles: Set<String>) {
    self.ages = ages
    self.styles = styles
  }
  
  convenience init?(data: [String: Any]) {
    guard let ages = data[Key.age.val] as? [Int],
      let styles = data[Key.style.val] as? [String] else { return nil }
    self.init(ages: ages, styles: Set(styles))
  }

  public func clear() {
    ages = ages.map { _ in 0 }
    styles = []
  }
  
  public func filtered(_ s: Setter) -> Bool {
    switch s.key {
    case .age: return filteredAge(s.value as! [Int])
    case .style: return filteredStyles(s.value as! [String])
    }
  }
  
  private func filteredAge(_ data: [Int]) -> Bool {
    if !ages.contains(1) { return true }
    for (i, e) in data.enumerated() { if ages[i] == e && e == 1 { return true } }
    return false
  }
  
  private func filteredStyles(_ data: [String]) -> Bool {
    if styles.count == 0 { return true }
    for s in data { if styles.contains(s) { return true } }
    return false
  }
  
  public func setFilterComponents(_ s: Setter) {
    switch s.key {
    case .age: age(s.value as! Int)
    case .style: style(s.value as! String)
    }
  }
  
  private func age(_ index: Int) {
    ages[index] = ages[index] == 1 ? 0 : 1
  }
  
  private func style(_ style: String) {
    if styles.contains(style) { styles.remove(style) }
    else { styles.insert(style) }
  }
}
