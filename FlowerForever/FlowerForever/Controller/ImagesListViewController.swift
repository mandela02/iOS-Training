//
//  ViewController.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {

    @IBOutlet weak var imagesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTable.dataSource = self
        imagesTable.delegate = self
        imagesTable.prefetchDataSource = self
        imagesTable.rowHeight = UITableView.automaticDimension
        imagesTable.estimatedRowHeight = 600
        ImagesData.shared.downloadImagesData {
            print("Number of links: \(ImagesData.shared.images.count)")
            self.imagesTable.reloadData()
        }
    }
}

extension ImageListViewController: UITableViewDelegate {}

extension ImageListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImagesData.shared.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.shared.cellIdentifier)
            as? ImageCell else {
                fatalError()
        }
        print(ImagesData.shared.images[indexPath.row].aspectRatio)
        cell.updateCellUi(flower: ImagesData.shared.images[indexPath.row])
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.width
//            * CGFloat(ImagesData.shared.images[indexPath.row].aspectRatio)
//            + CGFloat(Const.shared.defaultTitleHeight)
//            + CGFloat(Const.shared.defaultButtonHeight)
//    }
}

extension ImageListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if indexPath.row == ImagesData.shared.images.count - 1 {
                Const.shared.page += 1
                ImagesData.shared.downloadImagesData {
                    print("Number of links: \(ImagesData.shared.images.count)")
                    tableView.reloadData()
                }
            }
        }
    }
}
