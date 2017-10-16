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
  
  @IBOutlet weak var initializeButton: UIBarButtonItem!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  @IBOutlet weak var filterTableView: UITableView!
  
  var viewModel: FilterViewModel!
  let disposeBag = DisposeBag()
  let dataSource = RxTableViewSectionedAnimatedDataSource<FilterSection>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    
    viewModel.items
      .bind(to: filterTableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }

  func bind() {
    cancelButton.rx.action = viewModel.cancelAction
    confirmButton.rx.action = viewModel.confirmAction
    initializeButton.rx.bind(to: viewModel.initializeAction) { [weak self] _ in
      if let base = self { base.filterTableView.reloadData() }
    }
  }

  private func configure() {
    filterTableView.register(FilterTableViewCell.self)
    filterTableView.rowHeight = UITableViewAutomaticDimension
    filterTableView.estimatedRowHeight = 100
    filterTableView.separatorStyle = .none
    
    dataSource.titleForHeaderInSection = { data, index in
      data.sectionModels[index].model
    }
    
    dataSource.configureCell = { [weak self] data, tableView, indexPath, type in
      let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FilterTableViewCell
      if let base = self {
        cell.configure(type: type, update: base.viewModel.selectAction, set: base.viewModel.filterSet.exposed)
      }
      return cell
    }
  }
}
