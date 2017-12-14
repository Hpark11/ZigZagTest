//
//  FilterViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
  
  // 멤버변수 표기 활성화 + m
  @IBOutlet weak var initializeButton: UIBarButtonItem!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var filterTableView: UITableView!
  
  
  // 필터의 접근할 개체 구분하기 위해 접근제어 추가
  var filter = FilterManager.shared.getFilter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    filterTableView.delegate = self
    filterTableView.dataSource = self
    
    filterTableView.rowHeight = UITableViewAutomaticDimension
    filterTableView.estimatedRowHeight = 180
    filterTableView.register(AgeFilterTableViewCell.self)
    filterTableView.register(StyleFilterTableViewCell.self)
  }
  
  // 메소드 명칭 좀더 구체화 (하려고 하는 행동에 대한 더욱더 명확한 정의 필요)
  @IBAction func onInitialized(_ sender: Any) {
    filter.clear()
    filterTableView.reloadData()
  }
  
  @IBAction func onCanceled(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onConfirmed(_ sender: Any) {
    FilterManager.shared.setFilter(filter)
    dismiss(animated: true, completion: nil)
  }
  /////////////////////////////////////////////////////////
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0: return "Age"
    default: return "Style"
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as AgeFilterTableViewCell
      cell.configure(filter: filter)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as StyleFilterTableViewCell
      cell.configure(filter: filter)
      return cell
    }
  }
}
