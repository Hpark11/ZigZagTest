//
//  ModelBase.swift
//  ZigZagTest
//
//  Created by croquiscom on 2017. 12. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

struct ModelBase<T> {
  let path: String
  let parse: (Data) -> T?
}

extension ModelBase {
  init(path: String, parser: @escaping (Any) -> T?) {
    self.path = path
    self.parse = { data in
      let json = try? JSONSerialization.jsonObject(with: data, options: [])
      return json.flatMap(parser)
    }
  }
}
