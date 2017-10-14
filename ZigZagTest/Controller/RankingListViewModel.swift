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
  let identifier: String = "RankingList"
  let navigator: NavigatorType

  
  
  var items: Observable<[ShopSection]> {
    return APIService.shoppingMalls
      .map { shops in
        let set = Filter.getFilterSet().exposed
        let filtered = shops
          .filter { $0.age.elementsEqual(set[Filter.Category.age.val] as! [Int]) }
          .filter { $0.style.elementsEqual(set[Filter.Category.style.val] as! [String]) }
        return [ShopSection(model: "", items: filtered)]
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
