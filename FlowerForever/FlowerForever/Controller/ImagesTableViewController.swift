//
//  ViewController.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol ReloadCollectionDelegate: class {
    func pleaseReloadYourCollection()
}

class ImagesTableViewController: UIViewController {

    @IBOutlet weak var imagesTableView: UITableView!
    weak var reloadDelegate: ReloadCollectionDelegate?
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        DispatchQueue.main.async {
            self.imagesTableView.scrollToRow(at: self.index ?? [0, 0], at: .top, animated: false)
        }
    }

    func initTableView() {
        imagesTableView.dataSource = self
        imagesTableView.delegate = self
        imagesTableView.prefetchDataSource = self
        imagesTableView.rowHeight = UITableView.automaticDimension
        imagesTableView.estimatedRowHeight = 2
    }

    func downloadData() {
        ImagesAPI.shared.downloadImagesData {
            self.imagesTableView.reloadData()
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
        cell.likeInTableViewCellDelegate = self
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
                DispatchQueue.main.async {
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
}

extension ImagesTableViewController: LikeInTableviewCellDelegate {
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

extension ImagesTableViewController: SendIndexPathDelegate {
    func sendThisIndexPath(indexPath: IndexPath) {
        index = indexPath
    }
}
