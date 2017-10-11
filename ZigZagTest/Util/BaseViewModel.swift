//
//  BaseViewModel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation

protocol BaseViewModel {
  var identifier: String { get }
  var navigator: NavigatorType { get }
}
