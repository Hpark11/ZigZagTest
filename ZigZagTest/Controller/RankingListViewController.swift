//
//  RankingListViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit

protocol RankingListViewControllerDelegate: class {
  func applyFilter()
}

class RankingListViewController: UIViewController, RankingListViewControllerDelegate {
  
  @IBOutlet weak var mShoppingMallTableView: UITableView!
  
  private var mMallsOrigin  = [ShoppingMall]()
  private var mMalls        = [ShoppingMall]()
  private var mWeek         = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    mShoppingMallTableView.register(ShoppingMallTableViewCell.self)
    
    APIService().request(ShoppingMall.week) { [unowned self] result in
      guard let week = result else { return }
      self.mWeek = week
    }
    
    APIService().request(ShoppingMall.list) { [unowned self] result in
      guard let malls = result else { return }
      self.mMallsOrigin = malls
      self.applyFilter()
    }
  }

  func applyFilter() {
    mMalls = FilterService.shared.filteredMalls(malls: mMallsOrigin)
    mShoppingMallTableView.reloadData()
  }
  
  @IBAction func openFilterViewController(_ sender: Any) {
    performSegue(withIdentifier: "openFilter", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "openFilter" {
      let nc = segue.destination as! UINavigationController
      guard let vc = nc.viewControllers.first as? FilterViewController else { return }
      vc.delegate = sender as? RankingListViewControllerDelegate
    }
  }
}

extension RankingListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return mWeek
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mMalls.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShoppingMallTableViewCell
    cell.configure(shop: mMalls[indexPath.row], index: indexPath.row)
    return cell
  }
}
