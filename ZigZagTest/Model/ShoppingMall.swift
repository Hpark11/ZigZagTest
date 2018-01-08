//
//  ShoppingMall.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

struct ShoppingMall {
  let name: String
  let url: String
  let style: [String]
  let age: [Int]
  let score: Int
}

extension ShoppingMall {
  init?(data: [String: Any]) {
    guard let name = data["n"] as? String,
      let url = data["u"] as? String,
      let style = data["S"] as? String,
      let age = data["A"] as? [Int],
      let score = data["0"] as? Int else { return nil }
    
    self.name = name
    self.url = url
    self.style = style.components(separatedBy: ",")
    self.age = age
    self.score = score
  }
}

extension ShoppingMall: Equatable {
  static func ==(lhs: ShoppingMall, rhs: ShoppingMall) -> Bool {
    return lhs.url == rhs.url
  }
}







