//
//  NavigatorType.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit
import RxSwift

protocol NavigatorType {
  init(window: UIWindow)
  func navigate(to scene: Stage, type: Stage.NavigationType) -> Observable<Void>
  func revert(animated: Bool) -> Observable<Void>
}

