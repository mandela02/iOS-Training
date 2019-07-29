//
//  CustomImageView.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL){
        self.image = nil
        let filename = url.lastPathComponent
        if let savedImage = ImagesAPI.shared.getImageFromCache(with: filename) {
            self.image = savedImage
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, err in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, err == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                ImagesAPI.shared.saveImageToCache(image, filename: filename)
            }
        }.resume()
    }

    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
    public func maskCircle() {
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}


