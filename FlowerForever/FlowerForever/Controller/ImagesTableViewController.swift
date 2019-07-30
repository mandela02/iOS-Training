//
//  ViewController.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol reloadCollectionDelegateProtocol: class {
    func pleaseReloadYourCollection()
}

class ImagesTableViewController: UIViewController {

    @IBOutlet weak var imagesTable: UITableView!
    weak var reloadDelegate: reloadCollectionDelegateProtocol?
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        DispatchQueue.main.async {
            self.imagesTable.scrollToRow(at: self.index ?? [0, 0], at: .top, animated: false)
        }
    }

    func initTableView() {
        imagesTable.dataSource = self
        imagesTable.delegate = self
        imagesTable.prefetchDataSource = self
        imagesTable.rowHeight = UITableView.automaticDimension
        imagesTable.estimatedRowHeight = 2
    }

    func downloadData() {
        ImagesAPI.shared.downloadImagesData {
            //print("Number of links: \(ImagesData.shared.images.count)")
            self.imagesTable.reloadData()
        }
    }

    func getCell(_ tableView: UITableView) -> ImageTableCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.shared.cellIdentifier)
            as? ImageTableCell else {
                fatalError()
        }
        return cell
    }
}

extension ImagesTableViewController: UITableViewDelegate {
}

extension ImagesTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImagesAPI.shared.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView)
        cell.mainImage = ImagesAPI.shared.images[indexPath.row]
        cell.likeDelegateInTableViewCell = self
        cell.setNil()
        cell.updateCellUi()
        return cell
    }
}

extension ImagesTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //print(indexPaths)
        indexPaths.forEach { indexPath in
            if indexPath.row == ImagesAPI.shared.images.count - 1 {
                Const.shared.page += 1
                ImagesAPI.shared.downloadImagesData {
                    tableView.reloadData()
                    if self.reloadDelegate != nil {
                        self.reloadDelegate?.pleaseReloadYourCollection()
                    }
                }
            }
        }
    }
}

extension ImagesTableViewController: LikeDelegateInTableviewCell {
    func imageTableCell(_ imageCell: ImageTableCell, likeButtonPressedFor image: Image) {
        if image.isLiked == true {
            ImagesAPI.shared.deleteImageInDatabase(imageId: image.imageID)
        } else {
            ImagesAPI.shared.saveImagetoDatabase(imageId: image.imageID)
        }
        image.isLiked = !image.isLiked
        imageCell.setLikeButtonImage()
    }
}

extension NSLayoutConstraint {
    override open var description: String {
        let constraintsID = identifier ?? ""
        return "id: \(constraintsID), constant: \(constant)"
    }
}

extension ImagesTableViewController: sendIndexPathProtocol {
    func sendThisIndexPath(indexPath: IndexPath) {
        index = indexPath
    }
}
