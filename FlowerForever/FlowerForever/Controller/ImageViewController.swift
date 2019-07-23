//
//  ViewController.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var flowerTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Url.yellowFlowersUrl)
        flowerTable.dataSource = self
        flowerTable.delegate = self
        FlowerImageData.sharedFlowerData.downloadFlowerDataFromInternet {
            self.flowerTable.reloadData()
            //print(FlowerImageData.sharedFlowerData.listOfFlowers)
        }
    }
}

extension ImageViewController: UITableViewDelegate {}

extension ImageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlowerImageData.sharedFlowerData.listOfFlowers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier) as? ImageCell else {
            fatalError()
        }
        cell.updateCellUi(flower: FlowerImageData.sharedFlowerData.listOfFlowers[indexPath.row])
        return cell
    }
}
