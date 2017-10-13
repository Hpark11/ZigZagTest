//
//  FilterViewModel.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

//typealias Filter
typealias FilterSection = AnimatableSectionModel<String, Filter.Category>

struct FilterViewModel: BaseViewModel {
  let identifier: String = "Filter"
  let navigator: NavigatorType
  let cancelAction: CocoaAction
  
  var filterSet: FilterSet
  
  var items: Observable<[FilterSection]> {
    return Observable<[FilterSection]>.create { observer in
      observer.onNext([
        FilterSection(model: "연령대", items: [.age]),
        FilterSection(model: "스타일", items: [.style])
        ])
      observer.onCompleted()
      return Disposables.create()
    }
  }
  
  func onConfirm() -> CocoaAction {
    return CocoaAction {
      UserDefaults.standard.set(self.filterSet.exposed, forKey: FilterSet.Key.all.rawValue)
      return self.navigator.revert(animated: true)
    }
  }
  
//  func onSelect() -> Action<FilterSet.Key, Void> {
//    return Action { key in
//      self.filterSet.set(key, value: <#T##Any#>)
//    }
//  }
  
  
//  func onSelect() -> CocoaAction {
//    return CocoaAction {
//
//    }
//  }

  init(navigator: NavigatorType) {
    self.navigator = navigator
    cancelAction = CocoaAction { navigator.revert(animated: true) }
    if let data = UserDefaults.standard.object(forKey: FilterSet.Key.all.rawValue) as? [String: Any],
      let set = FilterSet(data: data) {
      self.filterSet = set
    } else {
      self.filterSet = FilterSet()
    }
  }
}
