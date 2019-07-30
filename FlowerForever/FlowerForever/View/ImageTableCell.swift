//
//  ImageCell.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol LikeDelegate: class {
    func imageTableCell(_ imageCell: ImageTableCell, likeButtonPressedFor image: Image)
}

class ImageTableCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var userInformationView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    let mainImageTapGestureRecognizer = UITapGestureRecognizer()

    var isLiked = false
    weak var delegate: LikeDelegate?

    weak var mainImage: Image!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageTapGestureRecognizer.addTarget(self, action: #selector(ImageTableCell.mainImagePressedEvent))
        mainImageTapGestureRecognizer.numberOfTapsRequired = 2
        mainImageView.addGestureRecognizer(mainImageTapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func likeButtonPressedEvent(_ sender: Any) {
        setDelegate()
    }

    @objc func mainImagePressedEvent() {
        if mainImage.isLiked == false {
        setDelegate()
        }
        beginAnimation()
    }

    func setDelegate() {
        guard delegate != nil else {
            return
        }
        delegate?.imageTableCell(self, likeButtonPressedFor: mainImage)
    }

    func beginAnimation() {
        Animation.init().fadeOut(imageView: heartImageView)
    }

    func updateCellUi() {
        setLikeButtonImage()
        imageHeightConstraint.constant = UIScreen.main.bounds.width * CGFloat(mainImage.aspectRatio)
        mainImageView.image = nil
        mainImageView.downloaded(from: mainImage.largeImageURL)
        userImageView.maskCircle()
        userImageView.downloaded(from: mainImage.userImageURL)
        userNameLabel.text = mainImage.user
    }

    func setLikeButtonImage() {
        likeButton.setImage(UIImage(named: mainImage.isLiked ? "likeRed" : "like"), for: .normal)
    }
}
