//
//  Identifiable.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 12..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

protocol Identifiable: class {}

extension Identifiable where Self: UIView {
  static var identifier: String {
    return String(describing: self)
  }
}
