//
//  FilterViewModel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct FilterViewModel: BaseViewModel {
  let identifier: String = "Filter"
  let navigator: NavigatorType
  let onCancel: CocoaAction
  
  init(navigator: NavigatorType) {
    self.navigator = navigator
    onCancel = CocoaAction { navigator.revert(animated: true) }
  }
  
  
  
}
