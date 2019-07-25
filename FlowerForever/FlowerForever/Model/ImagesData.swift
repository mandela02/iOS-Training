//
//  FlowerImageData.swift
//  FlowerForever
//
//  Created by mac on 7/23/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class ImagesData {
    static let shared = ImagesData()
    var images: [Image] = []

    private init() {
    }

    func downloadImagesData(completed: @escaping () -> Void) {
        guard let imageURL = URL(string: Const.shared.imageURL) else {
            return
        }
        print("take: \(Const.shared.page)")
        Alamofire.request(imageURL).responseJSON { response in
            if let dict = response.value as? [String: AnyObject] {
                if let hits = dict["hits"] as? [[String: AnyObject]] {
                    for imageData in hits {
                        let image = Image(imageData: imageData)
                        self.images.append(image)
                    }
                    completed()
                    let totalHits = dict["totalHits"] as? Int ?? 0
                    if totalHits == self.images.count {
                        return
                    }
                }
            }
        }
    }

    private var cache: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    func saveImage(_ image: UIImage, filename: String) {
        let url = cache.appendingPathComponent(filename)
        guard let data = image.pngData() else {
            return
        }
        try? data.write(to: url)
    }

    func getImage(with filename: String) -> UIImage? {
        let url = cache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
