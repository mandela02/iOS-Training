//
//  ViewController.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var countryRoad = VideoModel(imageURL: "https://genknews.genkcdn.vn/2018/11/29/1-15434638123301942338788.jpg",
                                 name: "Take me home Country Road",
                                 videoURL: "<iframe width=\"100%\" height=\"450\" src=\"https://www.youtube.com/embed/FRPeYP6gS-s\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>")
    
    var songTitle = "Peple like us"
    var imageUrl = "http://cdn.collider.com/wp-content/uploads/2019/02/doom-patrol-matt-bomer-01.jpg"
    var videoUrl = "<iframe width=\"100%\" height=\"450\" src=\"https://www.youtube.com/embed/R3uKBCEyxC4\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
    
    var videos = [VideoModel]()
    
    var peopleLikeUs = VideoModel()
    
    func addData(){
        peopleLikeUs.imageURL = imageUrl
        peopleLikeUs.title = songTitle
        peopleLikeUs.videoURL = videoUrl
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addData()
        videos.append(peopleLikeUs)
        videos.append(countryRoad)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondVC {
            if let video = sender as? VideoModel {
                destination.video = video
            }
        }
    }
}

extension MainVC: UITableViewDelegate {

}

extension MainVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableViewCell else {
            fatalError("The dequeued cell is not an instance of Cell.")
        }
        cell.updateUI(video: videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PlayVideo", sender: videos[indexPath.row])
    }
}

