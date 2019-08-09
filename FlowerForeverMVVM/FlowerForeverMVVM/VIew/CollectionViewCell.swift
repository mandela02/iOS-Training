//
//  CollectionViewCell.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/9/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionViewImage: UIImageView!
    let downloader = ImageDownloader()

    let imageUrl: BehaviorRelay<String> = BehaviorRelay(value: "")
    private var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        imageUrl.accept("")
        collectionViewImage.image = nil
    }

    func updateUI(withData hit: Hit) {
        collectionViewImage.downloaded(from: hit.largeImageURL)
//        imageUrl.accept(hit.largeImageURL)
//        imageUrl.asObservable()
//            .flatMapLatest { url in
//                return self.downloader.downloadImage(from: url)
//            }.subscribe(onNext: { image in
//                self.collectionViewImage.image = image
//            }).disposed(by: disposeBag)
    }
}
