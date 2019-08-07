//
//  ViewController.swift
//  learnRxSwiftWithStyle
//
//  Created by mac on 8/5/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchView: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinding()
        ViewModel.shared.requestData()
        setUpSearchBar()
        updateCellTapEvent()
    }
    
    private func setUpBinding() {
        ViewModel.shared
            .friends.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell",
                                         cellType: TableViewCell.self)) {  row, friend, cell in
                                            cell.loadUI(withFriend: friend)
                                            
            }.disposed(by: disposeBag)
    }
    
    private func updateCellTapEvent() {
        tableView.rx.modelSelected(Friend.self)
            .subscribe(onNext: { [unowned self] friend in
                print(friend.number + ":" + friend.name)
                ViewModel.shared.selectedFriend.accept(friend)
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.performSegue(withIdentifier: "Segue", sender: self)
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            }).disposed(by: disposeBag)
    }

    private func setUpSearchBar() {
        searchView.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { query in
                ViewModel.shared.search(query: query)
            }).disposed(by: disposeBag)
    }
    
    private func prepareForSomething() {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let _ = segue.destination as? AddFriendViewController else {
            return
        }
    }
}

