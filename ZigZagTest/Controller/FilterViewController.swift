//
//  FilterViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate: class {
  func onFilterChanged()
}

class FilterViewController: UIViewController {
  weak var delegate: FilterViewControllerDelegate?
  
  @IBOutlet weak var mFilterTableView: UITableView!
  
  private var mAgeConditions: [Int]       = FilterService.shared.conditionsByAges
  private var mStyleConditions: [String]  = FilterService.shared.conditionsByStyles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mFilterTableView.register(AgeFilterTableViewCell.self)
    mFilterTableView.register(StyleFilterTableViewCell.self)
  }
  
  @IBAction func initializeFilter(_ sender: Any) {
    mAgeConditions = mAgeConditions.map {_ in 0}
    mStyleConditions = []
    mFilterTableView.reloadData()
  }
  
  @IBAction func cancelFilter(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func confirmFilterConditions(_ sender: Any) {
    FilterService.shared.setFilter(ages: mAgeConditions, styles: mStyleConditions)
    delegate?.onFilterChanged()
    dismiss(animated: true, completion: nil)
  }
  
  func checkAgeFilter(_ sender: RoundedButton) {
    mAgeConditions[sender.tag] = sender.isChecked ? 1 : 0
  }
  
  func checkStyleFilter(_ sender: RoundedButton) {
    guard let text = sender.titleLabel?.text else { return }
    if let index = mStyleConditions.index(of: text) {
      mStyleConditions.remove(at: index)
    } else {
      mStyleConditions.append(text)
    }
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
      cell.configure(conditions: mAgeConditions, check: checkAgeFilter)
      return cell
    default:
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as StyleFilterTableViewCell
      cell.configure(conditions: mStyleConditions, check: checkStyleFilter)
      return cell
    }
  }
}
