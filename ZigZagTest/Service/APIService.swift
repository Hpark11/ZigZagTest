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
}
