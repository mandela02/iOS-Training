//
//  MusicListVC.swift
//  learnSegue
//
//  Created by mac on 7/12/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class MusicListVC: UIViewController {
    
    
    @IBOutlet weak var loadMoreButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loadButtonPressed(_ sender: Any) {
        let title = "I dont want to set the world on fire"
        performSegue(withIdentifier: "SongVC", sender: title)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlaySongVC {
            if let song = sender as? String {
                destination.selectedSong = song
            }
        }
    }
    
    @IBAction func rewind(sender: UIStoryboardSegue)
    {
        if let source = sender.source as? PlaySongVC, let songTitle = source.songTitle {
            loadMoreButton.setTitle(songTitle, for: .normal)
        }
    }
}
