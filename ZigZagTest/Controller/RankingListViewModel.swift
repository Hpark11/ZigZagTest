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

class RankingListViewModel: BaseViewModel {
  typealias Key = Filter.Category
  
  let identifier: String = "RankingList"
  let navigator: NavigatorType
  let result: [String: Any]
  
  var items: Observable<[ShopSection]> {
    return APIService.shoppingMalls
      .map { shops in
        let set = Filter.getFilterSet()
        let filtered = set.isInitialized ? shops : shops
          .filter { set.filtered((key: Filter.Category.age, value: $0.age)) }
          .filter { set.filtered((key: Filter.Category.style, value: $0.style)) }
        return [ShopSection(model: "", items: filtered.sorted { $0.score > $1.score })]
      }
  }
  
  lazy var refresh: () -> (Void) = { [unowned self] _ in
    APIService.subject.onNext(self.result)
  }
  
  lazy var filterAction: CocoaAction = { this in
    return Action {
      let filterViewModel = FilterViewModel(navigator: this.navigator, refresh: this.refresh)
      return this.navigator.navigate(to: Stage.filter(filterViewModel), type: .modal(.normal))
    }
  }(self)
  
  init(navigator: NavigatorType) {
    self.navigator = navigator
    result = APIService.request()
    APIService.subject.onNext(self.result)
  }
}
