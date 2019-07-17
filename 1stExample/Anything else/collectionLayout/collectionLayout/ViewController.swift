//
//  ViewController.swift
//  collectionLayout
//
//  Created by mac on 7/10/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func rewindTime(sender: UIStoryboardSegue)
    {
        if let source = sender.source as? CollectionViewController, let name = source.oneName {
            mLabel.text = name
        }
    }
}

