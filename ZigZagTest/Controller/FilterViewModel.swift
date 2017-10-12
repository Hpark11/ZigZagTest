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

typealias FilterSection = AnimatableSectionModel<String, Constants.FilterType>

struct FilterViewModel: BaseViewModel {
  let identifier: String = "Filter"
  let navigator: NavigatorType
  let onCancel: CocoaAction
  
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
  
  init(navigator: NavigatorType) {
    self.navigator = navigator
    onCancel = CocoaAction { navigator.revert(animated: true) }
  }
}
