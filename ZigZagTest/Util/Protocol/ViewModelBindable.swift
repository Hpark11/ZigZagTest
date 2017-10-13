//
//  Bindable.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

protocol ViewModelBindable {
  associatedtype ViewModel
  var viewModel: ViewModel! { get set }
  func bind()
}

extension ViewModelBindable where Self: UIViewController {
  mutating func bind(to model: Self.ViewModel) {
    viewModel = model
    loadViewIfNeeded()
    bind()
  }
}
