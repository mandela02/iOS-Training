//
//  TableViewCell.swift
//  FlowerForeverMVVM
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!

    var mainImageTapGestureRecognizer = UITapGestureRecognizer()
    var disposeBag = DisposeBag()

    var viewModel = ViewModelForCell(withCurrentHit: BehaviorRelay(value: Hit()))

    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        mainImageView.image = nil
        disposeBag = DisposeBag()
        mainImageTapGestureRecognizer = UITapGestureRecognizer()
        viewModel = ViewModelForCell(withCurrentHit: BehaviorRelay(value: Hit()))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageTapGestureRecognizer.addTarget(self, action: #selector(TableViewCell.mainImagePressedEvent))
        mainImageTapGestureRecognizer.numberOfTapsRequired = 2
        mainImageView.addGestureRecognizer(mainImageTapGestureRecognizer)
    }

    @IBAction func likeButtonPressed(_ sender: Any) {
        viewModel.likeButtonTapped()
        viewModel.isInDatabase.subscribe(onNext: { isInDatabase in
            self.likeButton.rx.image(for: .normal).onNext(UIImage(named: isInDatabase ? "likeRed" : "like"))
        }).disposed(by: disposeBag)
    }

    @objc func mainImagePressedEvent() {
        likeButton.rx.image(for: .normal).onNext(UIImage(named: "likeRed"))
        viewModel.isInDatabase.subscribe(onNext: { isIndatabase in
            if !isIndatabase {
                self.viewModel.saveImagetoDatabase()
            }
        }).disposed(by: disposeBag)
        beginAnimation()
    }

    func beginAnimation() {
        Animation.init().fadeOut(imageView: heartImageView)
    }

    func updateUI(withHit hit: Hit) {
        imageHeightConstraint.constant = UIScreen.main.bounds.width * CGFloat(hit.imageHeight/hit.imageWidth)
        mainImageView.downloaded(from: hit.largeImageURL)
        userImageView.maskCircle()
        userImageView.downloaded(from: hit.userImageURL)
        userNameLabel.text = hit.user
        viewModel.isInDatabase.subscribe(onNext: { isInDatabase in
            self.likeButton.rx.image(for: .normal).onNext(UIImage(named: isInDatabase ? "likeRed" : "like"))
        }).disposed(by: disposeBag)
    }

    func setUpLikeButton(_ isInDatabase: Bool) -> BehaviorRelay<UIImage> {
        let buttonImage: BehaviorRelay<UIImage> = BehaviorRelay(value: UIImage())
        buttonImage.accept(UIImage(named: isInDatabase ? "likeRed" : "like")!)
        return buttonImage
    }
}
