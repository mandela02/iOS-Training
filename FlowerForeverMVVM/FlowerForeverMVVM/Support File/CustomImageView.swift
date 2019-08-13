//
//  CustomImageView.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UIImageView {
    func downloaded(from link: String) {
        self.image = nil

//        if let savedImage = ViewModel.shared.getImageFromCache(inLink: link) {
//            self.image = savedImage
//            return
//        }

        guard let url = URL(string: link) else { return }

        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, err == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                //ViewModel.shared.saveToCache(image, inLink: link)
                self.image = image
            }
        }.resume()
    }
//    func downloaded(from link: String) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url)
//    }

    public func maskCircle() {
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}

class ImageDownloader {
    func downloadImage(from link: String) -> Observable<UIImage> {
        guard let url = URL(string: link) else {
            fatalError("you have been warned")
        }

        return Observable.create({ observer in
            let request = URLSession.shared.dataTask(with: url) { data, response, err in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, err == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    observer.onNext(image)
                }
            }
            request.resume()
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
