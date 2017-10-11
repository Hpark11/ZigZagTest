//
//  RankingListViewModel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct RankingListViewModel: BaseViewModel {
  let identifier: String = "RankingList"
  let navigator: NavigatorType

  init(navigator: NavigatorType) {
    self.navigator = navigator
  }
  
  lazy var filterAction: CocoaAction = { this in
    return Action {
      let filterViewModel = FilterViewModel(navigator: this.navigator)
      return this.navigator.navigate(to: Stage.filter(filterViewModel), type: .modal(.normal))
    }
  }(self)
  
}
