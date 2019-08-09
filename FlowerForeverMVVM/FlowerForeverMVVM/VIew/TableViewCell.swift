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

    let mainImageTapGestureRecognizer = UITapGestureRecognizer()
    let viewModel = ViewModelForCell()
    var hit: Hit!
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func likeButtonTapped(_ sender: Any) {
//        viewModel
//            .isInDatabase
//            .asObservable()
//            .subscribe(onNext: { [weak self] isInDatabase in
//                if isInDatabase {
//                    self?.viewModel.deleteImageInDatabase()
//                    self?.likeButton.setImage(UIImage(named: "like"), for: .normal)
//                } else {
//                    self?.viewModel.saveImagetoDatabase()
//                    self?.likeButton.setImage(UIImage(named: "likeRed"), for: .normal)
//                }
//            self?.viewModel.initData()
//        }).disposed(by: disposeBag)
    }

    @objc func mainImagePressedEvent() {
//        viewModel.isInDatabase.asObservable().subscribe(onNext: { [weak self] isInDatabase in
//            if !isInDatabase {
//                self?.viewModel.likeButtonTapped()
//                self?.likeButton.setImage(UIImage(named: "likeRed"), for: .normal)
//                self?.viewModel.initData()
//            }
//        }).disposed(by: disposeBag)
        beginAnimation()
    }

    func beginAnimation() {
        Animation.init().fadeOut(imageView: heartImageView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        disposeBag = DisposeBag()
        viewModel.favoriteImage.accept(0)
    }

    func updateUI() {
        viewModel.favoriteImage.accept(hit.id)
        imageHeightConstraint.constant = UIScreen.main.bounds.width * CGFloat(hit.imageHeight/hit.imageWidth)
        mainImageView.downloaded(from: hit.largeImageURL)
        userImageView.maskCircle()
        userImageView.downloaded(from: hit.userImageURL)
        userNameLabel.text = hit.user
        viewModel.isInDatabase.asObservable().subscribe(onNext: { [weak self] isInDatabase in
            self?.likeButton.setImage(UIImage(named: isInDatabase ? "likeRed":"like"), for: .normal)
        }).disposed(by: disposeBag)
        mainImageTapGestureRecognizer.addTarget(self, action: #selector(TableViewCell.mainImagePressedEvent))
        mainImageTapGestureRecognizer.numberOfTapsRequired = 2
        mainImageView.addGestureRecognizer(mainImageTapGestureRecognizer)
    }
}
