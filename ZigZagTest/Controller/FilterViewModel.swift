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

typealias Setter = (key: Filter.Category, value: Any)
typealias FilterSection = AnimatableSectionModel<String, Filter.Category>

struct FilterViewModel: BaseViewModel {
  let identifier: String = "Filter"
  let navigator: NavigatorType
  let cancelAction: CocoaAction
  
  let filterSet: FilterSet
  
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
      UserDefaults.standard.set(self.filterSet.exposed, forKey: Filter.identifier)
      return self.navigator.revert(animated: true)
    }
  }
  
  func onSelect() -> Action<Setter, Void> {
    return Action { setter in
      self.filterSet.setFilter(setter)
      return Observable.just()
    }
  }
  
//  func onSelect() -> CocoaAction {
//    return CocoaAction {
//
//    }
//  }

  init(navigator: NavigatorType) {
    self.navigator = navigator
    cancelAction = CocoaAction { navigator.revert(animated: true) }
    if let data = UserDefaults.standard.object(forKey: Filter.identifier) as? [String: Any],
      let set = FilterSet(data: data) {
      self.filterSet = set
    } else {
      self.filterSet = FilterSet()
    }
  }
}
