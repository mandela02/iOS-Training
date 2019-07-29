//
//  ImageCell.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol LikeDelegate: class {
    func imageCell(_ imageCell: ImageCell, likeButtonPressedFor image: Image)
}

class ImageCell: UITableViewCell {

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
        mainImageTapGestureRecognizer.addTarget(self, action: #selector(ImageCell.mainImagePressedEvent))
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
        delegate?.imageCell(self, likeButtonPressedFor: mainImage)
    }

    func beginAnimation() {
        heartImageView.isHidden = false
        heartImageView.image = UIImage(named: "likeWhite")
        heartImageView.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.heartImageView.alpha = 0.0
        }) { _ in
            self.heartImageView.isHidden = true
        }
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

extension UIView {
    func fadeIn() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }

    func fadeOut() {
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseIn, animations: {
            self.alpha = 0.3
        }, completion: nil)
    }
}
