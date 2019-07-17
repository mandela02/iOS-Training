//
//  PlaySongVC.swift
//  learnSegue
//
//  Created by mac on 7/12/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class PlaySongVC: UIViewController {

    @IBOutlet weak var songTilteLbl: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    private var _selectedSong: String!
    
    var songTitle: String?
    
    private var _string: String!
    
    var getString: String{
        get{
            return _string
        }
        set {
            _string = newValue
        }
    }
    
    var selectedSong: String{
        get {
            return _selectedSong
        }
        set {
            _selectedSong = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTilteLbl.text = _selectedSong
        songTilteLbl.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let label = sender as? UIButton, label == exitButton else {
            return
        }
        songTitle = selectedSong
    }
}
