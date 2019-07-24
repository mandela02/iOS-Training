//
//  ViewController.swift
//  PrefetchingForTableview
//
//  Created by mac on 7/18/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Model {
        let urlString: String
        var url: URL {
            return URL(string: self.urlString)!
        }
        var image: UIImage?
        
        init(urlString: String) {
            self.urlString = urlString
        }
    }
    
    var items =
        [Model(urlString: "http://www.gstatic.com/webp/gallery/1.jpg"),
         Model(urlString: "http://www.gstatic.com/webp/gallery/2.jpg"),
         Model(urlString: "http://www.gstatic.com/webp/gallery/3.jpg"),
         Model(urlString: "http://www.gstatic.com/webp/gallery/4.jpg"),
         Model(urlString: "http://www.gstatic.com/webp/gallery/5.jpg"),
         Model(urlString: "http://imgsv.imaging.nikon.com/lineup/coolpix/a/a/img/sample/img_06_l.jpg"),
         Model(urlString: "http://imgsv.imaging.nikon.com/lineup/coolpix/a/a/img/sample/img_07_l.jpg"),
         Model(urlString: "http://imgsv.imaging.nikon.com/lineup/coolpix/a/a/img/sample/img_08_l.jpg"),
         Model(urlString: "http://imgsv.imaging.nikon.com/lineup/coolpix/a/a/img/sample/img_09_l.jpg"),
         Model(urlString: "http://imgsv.imaging.nikon.com/lineup/coolpix/a/a/img/sample/img_10_l.jpg"),
         Model(urlString: "https://www.gstatic.com/webp/gallery3/1.png"),
         Model(urlString: "https://www.gstatic.com/webp/gallery3/2.png"),
         Model(urlString: "https://www.gstatic.com/webp/gallery3/3.png"),
         Model(urlString: "https://www.gstatic.com/webp/gallery3/4.png"),
         Model(urlString: "https://www.gstatic.com/webp/gallery3/5.png")]

    @IBOutlet weak var tblExampleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblExampleTableView.dataSource = self
        tblExampleTableView.prefetchDataSource = self
    }
    
    private var tasks:[URLSessionTask] = []
    
    func downloadImage(forItemAtIndex index: Int) {
        let url = items[index].url
        guard tasks.index(where: {$0.originalRequest?.url == url}) == nil
            else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.items[index].image = image
                    let indexPath = IndexPath(row: index , section: 0)
                    if self.tblExampleTableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                        self.tblExampleTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    }
                }
            }
        }
        task.resume()
        tasks.append(task)
    }
    
    func cancelDownload(forItemAtIndex index: Int) {
        let url = items[index].url
        guard let index = tasks.index(where: { task in
            task.originalRequest?.url == url
        }) else {
            return
        }
        let task = tasks[index]
        task.cancel()
        tasks.remove(at: index)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? Cell else {
            fatalError("you are all dead")
        }
        if let image = items[indexPath.row].image {
            cell.imgView.image = image
        } else {
            cell.imgView.image = nil
            self.downloadImage(forItemAtIndex: indexPath.row)
        }
        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetchRowsAt \(indexPaths)")
        indexPaths.forEach { index in
            self.downloadImage(forItemAtIndex: index.row)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("cancelPrefetchingForRowsAt \(indexPaths)")
        indexPaths.forEach { (index) in
            self.cancelDownload(forItemAtIndex: index.row)
        }
    }
}

