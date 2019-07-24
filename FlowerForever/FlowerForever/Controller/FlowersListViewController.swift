//
//  ViewController.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class FlowerListViewController: UIViewController {

    @IBOutlet weak var flowerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        flowerTable.dataSource = self
        flowerTable.delegate = self
        flowerTable.prefetchDataSource = self
        FlowersData.shared.downloadFlowersData {
            print("Number of links: \(FlowersData.shared.flowers.count)")
            self.flowerTable.reloadData()
        }
    }
}

extension FlowerListViewController: UITableViewDelegate {}

extension FlowerListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlowersData.shared.flowers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.shared.cellIdentifier)
            as? ImageCell else {
                fatalError()
        }
        print(indexPath)
        cell.updateCellUi(flower: FlowersData.shared.flowers[indexPath.row])
        return cell
    }
}

extension FlowerListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
        indexPaths.forEach { indexPath in
            if indexPath.row == FlowersData.shared.flowers.count - 1 {
                Const.shared.page += 1
                FlowersData.shared.downloadFlowersData {
                    print("Number of links: \(FlowersData.shared.flowers.count)")
                    tableView.reloadData()
                }
            }
        }
    }
}
