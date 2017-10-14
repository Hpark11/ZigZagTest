//
//  RankingListViewModel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias ShopSection = AnimatableSectionModel<String, ShoppingMall>

struct RankingListViewModel: BaseViewModel {
  typealias Key = Filter.Category
  
  let identifier: String = "RankingList"
  let navigator: NavigatorType

  var items: Observable<[ShopSection]> {
    return APIService.shoppingMalls
      .map { shops in
        let set = Filter.getFilterSet()
        let filtered = set.isInitialized ? shops : shops
          .filter {
            guard let board = set.exposed[Key.age.val] as? [Int] else { return false }
            for (i, e) in $0.age.enumerated() { if board[i] == e && e == 1 { return true } }
            return false
          }.filter {
            guard let board = set.exposed[Key.style.val] as? [String] else { return false }
            for s in $0.style { if board.contains(s) { return true } }
            return false
          }
        
        return [ShopSection(model: "", items: filtered.sorted { $0.score > $1.score })]
      }
  }
  
  lazy var filterAction: CocoaAction = { this in
    return Action {
      let filterViewModel = FilterViewModel(navigator: this.navigator)
      return this.navigator.navigate(to: Stage.filter(filterViewModel), type: .modal(.normal))
    }
  }(self)
  
  init(navigator: NavigatorType) {
    self.navigator = navigator
  }
  
}
