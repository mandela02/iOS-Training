//
//  ImageCollectionCell.swift
//  FlowerForever
//
//  Created by mac on 7/29/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol LikeDelegateInCollectionCell: class {
    func imageCollectionCell(_ imageCell: ImageCollectionCell, likeButtonPressedFor image: Image)
}

class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    weak var mainImage: Image!
    let mainImageTapGestureRecognizer = UITapGestureRecognizer()
    weak var likeDelegateInCollectionViewCell: LikeDelegateInCollectionCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageTapGestureRecognizer.addTarget(self, action: #selector(ImageCollectionCell.mainImagePressedEvent))
        mainImageTapGestureRecognizer.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(mainImageTapGestureRecognizer)
    }

    func updateCellUi() {
        imageView.image = nil
        imageView.downloaded(from: mainImage.largeImageURL)
        updatelikeImage()
    }

    func beginAnimation() {
        Animation.init().fadeOut(imageView: heartImageView)
    }

    @objc func mainImagePressedEvent() {
        likeDelegateInCollectionViewCell?.imageCollectionCell(self, likeButtonPressedFor: mainImage)
        beginAnimation()
    }

    func updatelikeImage() {
        likeImageView.isHidden = !mainImage.isLiked
    }
}
