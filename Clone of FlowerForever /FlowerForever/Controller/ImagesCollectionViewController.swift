//
//  ImagesGirdViewController.swift
//  FlowerForever
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol SendIndexPathDelegate: class {
    func sendThisIndexPath(indexPath: IndexPath)
}

class ImagesCollectionViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet var superView: UIView!

    weak var sendIndexProtocol: SendIndexPathDelegate?

    var bigImageIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let old = oldValue {
                indexPaths.append(old)
            }
            if let new = bigImageIndexPath {
                indexPaths.append(new)
            }
            self.imagesCollectionView.performBatchUpdates({
                imagesCollectionView.reloadItems(at: indexPaths)
            }) { (_) in
                if let new = self.bigImageIndexPath {
                    self.imagesCollectionView.scrollToItem(at: new,
                                                       at: .centeredVertically,
                                                       animated: true)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        downloadData()
    }
    func initCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.prefetchDataSource = self
    }

    func downloadData() {
        ImagesAPI.shared.downloadImagesData {
            if ImagesAPI.shared.images.count == 0 {
                self.createEmptyImage()
            } else {
                self.imagesCollectionView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ImagesTableViewController else {
            fatalError()
        }
        destination.reloadDelegate = self
        self.sendIndexProtocol = destination
        self.sendIndexProtocol?.sendThisIndexPath(indexPath: sender as? IndexPath ?? [0, 0])
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func createEmptyImage() {
        imagesCollectionView.isHidden = true
        let imageView = UIImageView()
        superView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.downloaded(from: "https://cdn.dribbble.com/users/1554526/screenshots/3399669/no_results_found.png")
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
        cell.likeDelegateInCollectionViewCell = self
        return cell
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == bigImageIndexPath {
            let width = UIScreen.main.bounds.size.width
                - Const.shared.sectionInsets.left
                - Const.shared.sectionInsets.right
            let height = width * CGFloat(ImagesAPI.shared.images[indexPath.item].aspectRatio)
            return CGSize(width: width, height: height)
        }
        let padding = Const.shared.sectionInsets.left
            + Const.shared.sectionInsets.right
            + (Const.shared.sectionInsets.left * (Const.shared.numberOfCellinRow - 1))
//        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewFlowLayout.minimumLineSpacing 
//        }
        let size = Int((UIScreen.main.bounds.width - padding) / Const.shared.numberOfCellinRow)
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Const.shared.sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Const.shared.sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.shared.sectionInsets.bottom
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if bigImageIndexPath == indexPath {
            bigImageIndexPath = nil
            return false
        } else {
            bigImageIndexPath = indexPath
            return true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueToTableView", sender: indexPath)
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if indexPath.item == ImagesAPI.shared.images.count - 1 {
                Const.shared.page += 1
                DispatchQueue.main.async {
                    ImagesAPI.shared.downloadImagesData {
                        collectionView.reloadData()
                    }
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print(indexPaths)
    }
}

extension ImagesCollectionViewController: LikeInCollectionCellDelegate {
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

extension ImagesCollectionViewController: ReloadCollectionDelegate {
    func pleaseReloadYourCollection() {
        imagesCollectionView.reloadData()
    }
}
