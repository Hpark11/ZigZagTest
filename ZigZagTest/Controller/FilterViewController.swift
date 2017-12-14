//
//  FilterViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
  
  @IBOutlet weak var initializeButton: UIBarButtonItem!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var filterTableView: UITableView!
  
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
