//
//  RankingListViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit


class RankingListViewController: UIViewController, ViewModelBindable {
  @IBOutlet weak var filterButton: UIBarButtonItem!
  
  var viewModel: RankingListViewModel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
  }
  
  func bind() {
    filterButton.rx.action = viewModel.filterAction
  }
    
  
  

}
