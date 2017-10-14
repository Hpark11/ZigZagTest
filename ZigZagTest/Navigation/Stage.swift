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
  private func getVC(id: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "ZigZag", bundle: nil)
    let nc = storyboard.instantiateViewController(withIdentifier: id) as! UINavigationController
    return nc.viewControllers.first!
  }

  func viewController() -> UIViewController {
    switch self {
    case .ranking(let viewModel):
      var vc = getVC(id: viewModel.identifier) as! RankingListViewController
      vc.bind(to: viewModel)
      return vc.navigationController!
    case .filter(let viewModel):
      var vc = getVC(id: viewModel.identifier) as! FilterViewController
      vc.bind(to: viewModel)
      return vc.navigationController!
    }
  }
}
