//
//  RankingListViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

class RankingListViewController: UIViewController {
  @IBOutlet weak var filterButton: UIBarButtonItem!
  @IBOutlet weak var shoppingMallTableView: UITableView!
  
  var malls = [ShoppingMall]()
  var week = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shoppingMallTableView.delegate = self
    shoppingMallTableView.dataSource = self
    shoppingMallTableView.separatorStyle = .none
    shoppingMallTableView.register(ShoppingMallTableViewCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    APIService().request(ShoppingMall.week) { [unowned self] result in
      guard let week = result else { return }
      self.week = week
    }
    
    APIService().request(ShoppingMall.list) { [unowned self] result in
      guard let shops = result else { return }
      
      let set = FilterManager.shared.getFilter()
      self.malls = set.isInitialized ? shops : shops
        .filter { set.filtered((key: Filter.Key.age, value: $0.age)) }
        .filter { set.filtered((key: Filter.Key.style, value: $0.style)) }
        .sorted { set.matches($0.style) == set.matches($1.style) ? $0.score > $1.score : set.matches($0.style) > set.matches($1.style) }
      self.shoppingMallTableView.reloadData()
    }
  }

  @IBAction func onOpenFilter(_ sender: Any) {
    performSegue(withIdentifier: "openFilter", sender: nil)
  }
}

extension RankingListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return week
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return malls.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShoppingMallTableViewCell
    cell.configure(shop: malls[indexPath.row], index: indexPath.row)
    return cell
  }
}
