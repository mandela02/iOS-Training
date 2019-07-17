//
//  TableViewCell.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(video: VideoModel)
    {
        lblName.text = video.title
        //let url = URL(string: video.imageURL)!
        //downloadImage(from: url)
        imgAvatar.downloaded(from: video.imageURL)
//        DispatchQueue.global().async {
//            do{
//                let data = try Data(contentsOf: url)
//                DispatchQueue.global().sync {
//                        self.imgAvatar.image = UIImage(data: data)
//                }
//            } catch {
//
//            }
//        }
     }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imgAvatar.image = UIImage(data: data)
            }
        }
    }
    
}

