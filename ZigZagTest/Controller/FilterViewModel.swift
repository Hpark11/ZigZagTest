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

class FilterViewModel: BaseViewModel {
  let identifier: String = "Filter"
  let navigator: NavigatorType
  let cancelAction: CocoaAction
  let refresh: () -> (Void)
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
  
  lazy var selectAction = Action<Setter, Void> { [unowned self] setter in
    self.filterSet.setFilterComponents(setter)
    return .just()
  }
  
  lazy var initializeAction = CocoaAction { [unowned self] in
    self.filterSet.clear()
    return .just()
  }
  
  func onConfirm() -> CocoaAction {
    return CocoaAction { [weak self] in
      if let base = self {
        Filter.setFilterSet(base.filterSet)
        base.refresh()
        return base.navigator.revert(animated: true)
      } else { return .just() }
    }
  }

  init(navigator: NavigatorType, refresh: @escaping () -> (Void)) {
    self.navigator = navigator
    self.refresh = refresh
    cancelAction = CocoaAction { navigator.revert(animated: true) }
    self.filterSet = Filter.getFilterSet()
  }
}
