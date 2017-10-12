//
//  FilterViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, ViewModelBindable {
  
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
  var viewModel: FilterViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func bind() {
    cancelButton.rx.action = viewModel.onCancel
  }


}
