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
import CoreData

class ImagesAPI {
    static let shared = ImagesAPI()
    var images: [Image] = []
    var tasks: [URLSessionDataTask] = []
    var coreDataDatabase = CoreDataDatabase()
    var realmDatabase = RealmDatabase()

    private init() {
    }

    func downloadImagesData(completed: @escaping () -> Void) {
        guard let imageURL = URL(string: Const.shared.imageURL) else {
            return
        }
        Alamofire.request(imageURL).responseJSON { response in
            if let dict = response.value as? [String: AnyObject] {
                if let hits = dict["hits"] as? [[String: AnyObject]] {
                    for imageData in hits {
                        let image = Image(imageData: imageData)
                        self.images.append(image)
//                        if self.coreDataDatabase.isInDatabase(imageId: image.imageID) {
//                            image.isLiked = true
//                        }
                        if self.realmDatabase.isInDatabase(forImageId: image.imageID) {
                            image.isLiked = true
                        }
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

    func saveImageToCache(_ image: UIImage, filename: String) {
        let url = cache.appendingPathComponent(filename)
        guard let data = image.pngData() else {
            return
        }
        try? data.write(to: url)
    }

    func getImageFromCache(with filename: String) -> UIImage? {
        let url = cache.appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }

    func saveImagetoDatabase(imageId: Int) {
        //coreDataDatabase.saveIntoDatabase(imageId: imageId)
        realmDatabase.insertToDatabase(withImageId: imageId)
    }

    func deleteImageInDatabase(imageId: Int) {
        //coreDataDatabase.deleteFromDatabase(imageId: imageId)
        realmDatabase.deleteFromDatabase(withImageId: imageId)
    }

    //    func downloadImageTask(forIndexPath index: Int) {
    //        guard let url = URL(string: Const.shared.imageURL) else {
    //            fatalError()
    //        }
    //        let task = URLSession.shared.dataTask(with: url) { data, response, err in
    //            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
    //                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
    //                let data = data, err == nil,
    //                let image = UIImage(data: data)
    //                else { return }
    //            DispatchQueue.main.async {
    //                self.images[index].image = image
    //            }
    //        }
    //        task.resume()
    //        tasks.append(task)
    //    }
    //
    //    func cancelDownloadingImage(forIndexPath index: Int) {
    //        guard let url = URL(string: Const.shared.imageURL) else {
    //            fatalError()
    //        }
    //        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url == url }) else {
    //            return
    //        }
    //        let task = tasks[taskIndex]
    //        task.cancel()
    //        tasks.remove(at: taskIndex)
    //    }
}
