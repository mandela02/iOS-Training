//
//  Database.swift
//  FlowerForever
//
//  Created by mac on 7/29/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Database {
    var likedImages: [NSManagedObject] = []

    init() {
        fetchImageData()
    }

    func saveIntoDatabase(imageId: Int) {
        guard let appDeletage = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDeletage.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "ImageData", in: managedContext)!

        let image = NSManagedObject(entity: entity, insertInto: managedContext)
        image.setValue(imageId, forKey: "id")

        do {
            try managedContext.save()
            self.likedImages.append(image)
            print(likedImages)
        } catch let err as NSError {
            print("can not save, \(err), \(err.userInfo)")
        }
    }

    func fetchImageData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ImageData")

        do {
            likedImages = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func isInDatabase(imageId: Int) -> Bool {
        var isInDb = false
        for obj in likedImages {
            if imageId == obj.value(forKey: "id") as? Int {
                isInDb = true
            }
        }
        return isInDb
    }

    func deleteFromDatabase(imageId: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        var deletedObject: NSManagedObject?
        for obj in likedImages {
            if obj.value(forKey: "id") as? Int == imageId {
                managedContext.delete(obj)
                deletedObject = obj
            }
        }
        if deletedObject != nil {
            if let removedItemIndex = likedImages.index(of: deletedObject!) {
                self.likedImages.remove(at: removedItemIndex)
            }
        }
        print(likedImages)
    }
}
