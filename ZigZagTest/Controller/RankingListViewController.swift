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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shoppingMallTableView.delegate = self
    shoppingMallTableView.dataSource = self
    shoppingMallTableView.separatorStyle = .none
    shoppingMallTableView.register(ShoppingMallTableViewCell.self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    APIService().request(ShoppingMall.list) { result in
      if let list = result {
        self.malls = list
        self.shoppingMallTableView.reloadData()
      }
    }
  }
  
  @IBAction func onOpenFilter(_ sender: Any) {
    performSegue(withIdentifier: "openFilter", sender: nil)
  }
}

extension RankingListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return malls.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShoppingMallTableViewCell
    cell.configure(shop: malls[indexPath.row], index: indexPath.row)
    return cell
  }
}
