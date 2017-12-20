//
//  APIService.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 14..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

final class APIService {
  func request<T>(_ model: ModelBase<T>, completion: @escaping (T?) -> Void) {
    guard let path = Bundle.main.path(forResource: model.path, ofType: "json", inDirectory: "zigzagRes"),
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
      completion(nil)
      return
    }
    completion(model.parse(data))
  }
  
  static let week = ModelBase<String>(path: "shopList", parser: { json in
    guard let dict = json as? [String: AnyObject], let week = dict["week"] as? String else {return nil}
    return week
  })
  
  static let shopList = ModelBase<[ShoppingMall]>(path: "shopList", parser: { json in
    guard let dict = json as? [String: AnyObject], let list = dict["list"] as? [[String: Any]] else {
      return nil
    }
    return list.flatMap(ShoppingMall.init)
  })
}
