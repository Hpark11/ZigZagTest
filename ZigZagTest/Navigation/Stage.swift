//
//  Stage.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

enum Stage {
  case ranking(RankingListViewModel)
  case filter(FilterViewModel)

  enum NavigationType {
    internal enum Show {
      case normal
      case detail
    }
    
    internal enum Modal {
      case normal
      case popOver
    }
    
    case root
    case show(Show)
    case modal(Modal)
  }

}

extension Stage {

//  private func bindViewModel<VC: UIViewController>(viewModel: BaseViewModel, storyboard: UIStoryboard) {
//    let nc = storyboard.instantiateViewController(withIdentifier: viewModel.identifier) as! UINavigationController
//    var vc = nc.viewControllers.first as! VC
//    vc.bindViewModel(to: viewModel)
//  }
  
  func viewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    switch self {
    case .ranking(let viewModel):
      let nc = storyboard.instantiateViewController(withIdentifier: viewModel.identifier) as! UINavigationController
      var vc = nc.viewControllers.first as! RankingListViewController
      vc.bind(to: viewModel)
      return nc
    case .filter(let viewModel):
      let nc = storyboard.instantiateViewController(withIdentifier: viewModel.identifier) as! UINavigationController
      var vc = nc.viewControllers.first as! FilterViewController
      vc.bind(to: viewModel)
      return nc
    }
  }
}
