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

        navigationItem.largeTitleDisplayMode = .automatic
        initTableView()
    }

    func initTableView() {
        imagesTable.dataSource = self
        imagesTable.delegate = self
        imagesTable.prefetchDataSource = self

//        imagesTable.rowHeight = UITableView.automaticDimension
//        imagesTable.estimatedRowHeight = 600

        ImagesData.shared.downloadImagesData {
            print("Number of links: \(ImagesData.shared.images.count)")
            self.imagesTable.reloadData()
        }
    }
}

extension ImageListViewController: UITableViewDelegate {}

extension ImageListViewController: UITableViewDataSource {

    func getCell(_ tableView: UITableView) -> ImageCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.shared.cellIdentifier)
            as? ImageCell else {
                fatalError()
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImagesData.shared.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView)
        cell.updateCellUi(image: ImagesData.shared.images[indexPath.row])
        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = getCell(tableView)
//        return tableView.frame.width
//            * CGFloat(ImagesData.shared.images[indexPath.row].aspectRatio)
//            + cell.buttonView.frame.height
//            + cell.userInformationView.frame.height
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

extension NSLayoutConstraint {
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
