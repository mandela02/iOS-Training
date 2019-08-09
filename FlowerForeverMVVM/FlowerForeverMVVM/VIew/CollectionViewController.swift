//
//  CollectionViewController.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/9/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.rx.setPrefetchDataSource(self).disposed(by: disposeBag)
        initSearchBar()
        initPrefetch()
    }

    private func initSearchBar() {
        ViewModel.shared.downloadDataFromServer()
        searchBar.rx.text
            .map {$0 ?? ""}
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: ViewModel.shared.currentQuery)
            .disposed(by: disposeBag)
        ViewModel.shared.currentQuery
            .subscribe(onNext: { (_) in
                ViewModel.shared.downloadDataFromServer()
            }).disposed(by: disposeBag)
        ViewModel.shared.currentQuery.flatMapLatest { _ in
                return ViewModel.shared.images
            }.bind(to: collectionView.rx.items(cellIdentifier: "Cell",
                                               cellType: CollectionViewCell.self)) { _, data, cell in
                                                cell.updateUI(withData: data)
            }.disposed(by: disposeBag)
    }

    private func initPrefetch() {
        ViewModel.shared.triggerFetchingMoreData.subscribe(onNext: { isPrefetching in
            if isPrefetching {
                ViewModel.shared.downloadDataFromServer()
            }
        }).disposed(by: disposeBag)
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ViewModel.shared.currentIndex.accept(indexPath)
        performSegue(withIdentifier: "Segue", sender: self)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Constants.sectionInsets.left
            + Constants.sectionInsets.right
            + (Constants.sectionInsets.left * (Constants.numberOfCellinRow - 1))
        //        if let collectionViewFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        //            collectionViewFlowLayout.minimumLineSpacing
        //        }
        let size = Int((UIScreen.main.bounds.width - padding) / Constants.numberOfCellinRow)
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.bottom
    }
}

extension CollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { index in
            ViewModel.shared.prefetchIndex.accept(index)
        }
    }
}
