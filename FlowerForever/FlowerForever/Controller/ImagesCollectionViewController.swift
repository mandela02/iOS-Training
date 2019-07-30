//
//  ImagesGirdViewController.swift
//  FlowerForever
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol reloadTableDelegateProtocol: class {
    func pleaseReloadYourTable()
}

class ImagesCollectionViewController: UIViewController {

    private let sectionInsets = UIEdgeInsets(top: 1.0,
                                             left: 1.0,
                                             bottom: 1.0,
                                             right: 1.0)

    @IBOutlet weak var imagesCollection: UICollectionView!
    weak var delegate: reloadTableDelegateProtocol?

    var bigImageIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let old = oldValue {
                indexPaths.append(old)
            }
            if let new = bigImageIndexPath {
                indexPaths.append(new)
            }
            self.imagesCollection.performBatchUpdates({
                imagesCollection.reloadItems(at: indexPaths)
            }) { (_) in
                if let new = self.bigImageIndexPath {
                    self.imagesCollection.scrollToItem(at: new,
                                                       at: .centeredVertically,
                                                       animated: true)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    func initCollectionView() {
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
        imagesCollection.prefetchDataSource = self
    }

    func downloadData() {
        ImagesAPI.shared.downloadImagesData {
            //print("Number of links: \(ImagesData.shared.images.count)")
            self.imagesCollection.reloadData()
        }
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImagesAPI.shared.images.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.shared.cellIdentifier,
                                                            for: indexPath) as? ImageCollectionCell else {
                                                                fatalError("your app suck")
        }
        cell.mainImage = ImagesAPI.shared.images[indexPath.item]
        cell.updateCellUi()
        cell.delegate = self
        return cell
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == bigImageIndexPath {
            let width = UIScreen.main.bounds.size.width - sectionInsets.left - sectionInsets.right
            let height = width * CGFloat(ImagesAPI.shared.images[indexPath.item].aspectRatio)
            return CGSize(width: width, height: height)
        }
        let totalSpace = sectionInsets.left
            + sectionInsets.right
            + (sectionInsets.left * (Const.shared.numberOfCellinRow - 1))
        let size = Int((UIScreen.main.bounds.width - totalSpace) / Const.shared.numberOfCellinRow)
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        if bigImageIndexPath == indexPath {
//            bigImageIndexPath = nil
//        } else {
//            bigImageIndexPath = indexPath
//        }
//        return false
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if bigImageIndexPath == indexPath {
//            bigImageIndexPath = nil
//        } else {
//            bigImageIndexPath = indexPath
//        }
//
//    }
}

extension ImagesCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if indexPath.item == ImagesAPI.shared.images.count - 1 {
                Const.shared.page += 1
                ImagesAPI.shared.downloadImagesData {
                    collectionView.reloadData()
                    if self.delegate != nil {
                        self.delegate?.pleaseReloadYourTable()
                    }
                }
            }
        }
    }
}

extension ImagesCollectionViewController: LikeDelegateInCollectionCell {
    func imageCollectionCell(_ imageCell: ImageCollectionCell, likeButtonPressedFor image: Image) {
        if image.isLiked == true {
            ImagesAPI.shared.deleteImageInDatabase(imageId: image.imageID)
        } else {
            ImagesAPI.shared.saveImagetoDatabase(imageId: image.imageID)
        }
        image.isLiked = !image.isLiked
        imageCell.updatelikeImage()
    }
}
