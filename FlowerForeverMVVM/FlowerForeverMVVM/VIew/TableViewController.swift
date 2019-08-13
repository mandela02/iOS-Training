//
//  ViewController.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 2
        initTableView()
        initPrefectch()
        let index = ViewModel.shared.currentIndex.value
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: index, at: .top, animated: false)
        }
        ViewModel.shared.currentIndex.accept(IndexPath())
    }

    func initTableView() {
        tableView.rx.setPrefetchDataSource(self).disposed(by: disposeBag)
        ViewModel
            .shared
            .images
            .asObservable()
            .bind(to: tableView
                .rx.items(cellIdentifier: "Cell",
                          cellType: TableViewCell.self)) { _, hit, cell in
                            cell.viewModel = ViewModelForCell(withCurrentHit: BehaviorRelay(value: hit))
                            cell.viewModel.currentHit.asObservable().subscribe(onNext: { hit in
                                cell.updateUI(withHit: hit)
                            }).disposed(by: cell.disposeBag)
//                            cell.viewModel
//                                .isInDatabase
//                                .asObservable()
//                                .flatMapLatest({ isInDatabase in
//                                    cell.setUpLikeButton(isInDatabase)
//                                })
//                                .bind(to: cell.likeButton.rx.image(for: .normal))
//                                .disposed(by: cell.disposeBag)
//                            cell.likeButton.rx.action = CocoaAction {
//                                cell.viewModel.likeButtonTapped()
//                                return .empty()
//                            }
            }.disposed(by: disposeBag)
    }

    private func initPrefectch() {
        ViewModel.shared.triggerFetchingMoreData.subscribe(onNext: { isPrefetching in
            if isPrefetching {
                ViewModel.shared.downloadDataFromServer()
            }
        }).disposed(by: disposeBag)
    }
}

extension TableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { index in
            ViewModel.shared.prefetchIndex.accept(index)
        }
    }
}
