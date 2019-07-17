//
//  SecondVC.swift
//  PartyRockMansion
//
//  Created by mac on 7/15/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit
import WebKit

class SecondVC: UIViewController {

    private var _video: VideoModel!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var video: VideoModel {
        get {
            return _video
        }
        set {
            _video = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadHTMLString(video.videoURL, baseURL: nil)
        name.text = video.title
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
