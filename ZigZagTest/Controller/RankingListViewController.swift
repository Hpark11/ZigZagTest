//
//  RankingListViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class RankingListViewController: UIViewController, ViewModelBindable {
  @IBOutlet weak var filterButton: UIBarButtonItem!
  @IBOutlet weak var shoppingMallTableView: UITableView!
  
  var week = Variable<String>("")
  var viewModel: RankingListViewModel!
  
  let disposeBag = DisposeBag()
  let dataSource = RxTableViewSectionedAnimatedDataSource<ShopSection>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    
    viewModel.items
      .bind(to: shoppingMallTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
  
  func bind() {
    filterButton.rx.action = viewModel.filterAction
    APIService.week.bind(to: week).disposed(by: disposeBag)
  }
  
  private func configure() {
    shoppingMallTableView.register(ShoppingMallTableViewCell.self)
    shoppingMallTableView.estimatedRowHeight = 64
    shoppingMallTableView.separatorStyle = .none

    dataSource.titleForHeaderInSection = { [weak self] _ in
      guard let base = self else { return "" }
      return base.week.value
    }
    
    dataSource.configureCell = { [weak self] data, tableView, indexPath, type in
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ShoppingMallTableViewCell
      if let base = self { cell.configure() }
      return cell
    }
  }
    
  
  

}
