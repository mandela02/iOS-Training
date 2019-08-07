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

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 2
        initTableView()
        initSearchBar()
        continueFetch()
    }

    func initTableView() {
//        ViewModel
//            .shared
//            .images
//            .asObservable()
//            .bind(to: tableView
//                .rx.items(cellIdentifier: "Cell",
//                          cellType: TableViewCell.self)) { row, hit, cell in
//                            cell.updateUI(hit: hit)
//            }.disposed(by: disposeBag)
    }

    private func initSearchBar() {
        searchBar
            .rx.text.orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest({ query in
                    return ViewModel.shared.requireDataFromServer(withQuery: query)
            }).bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: TableViewCell.self)) { row, hit, cell in
                cell.updateUI(hit: hit)
            }.disposed(by: disposeBag)
    }

    private func continueFetch() {    }
}
