//
//  FilterViewController.swift
//  ZigZagTest
//
//  Created by hPark_ipl on 2017. 10. 11..
//  Copyright © 2017년 hPark. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class FilterViewController: UIViewController, ViewModelBindable {
  
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var filterTableView: UITableView!
  
  var viewModel: FilterViewModel!
  let disposeBag = DisposeBag()
  let dataSource = RxTableViewSectionedAnimatedDataSource<FilterSection>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    filterTableView.register(FilterTableViewCell.self)
    filterTableView.rowHeight = UITableViewAutomaticDimension
    filterTableView.estimatedRowHeight = 100
    filterTableView.separatorStyle = .none
    
    configure()
    
    viewModel.items
      .bind(to: filterTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }

  func bind() {
    cancelButton.rx.action = viewModel.cancelAction
    confirmButton.rx.action = viewModel.onConfirm()
  }

  private func configure() {
    dataSource.titleForHeaderInSection = { data, index in
      data.sectionModels[index].model
    }
    
    dataSource.configureCell = { [weak self] data, tableView, indexPath, type in
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FilterTableViewCell
      cell.configure(type: type)
      return cell
    }
  }
}
