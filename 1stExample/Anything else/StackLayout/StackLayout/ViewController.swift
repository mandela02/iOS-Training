//
//  ViewController.swift
//  StackLayout
//
//  Created by mac on 7/5/19.
//  Copyright © 2019 CenterItemPagingCollectionView. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mTextMiddle: UITextField!
    @IBOutlet weak var mTextFirst: UITextField!
    @IBOutlet weak var mTextLast: UITextField!
    @IBOutlet weak var mTextInfor: UITextView!
    @IBOutlet weak var MTextSave: UIButton!
    @IBOutlet weak var mTextCancel: UIButton!
    @IBOutlet weak var mTextDelete: UIButton!
    @IBOutlet weak var mImageHome: UIImageView!
    
    var mStringFirst: String!
    var mStringMiddle: String!
    var mStringLast: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mImageHome.image = nil
        mTextFirst.text = "Who"
        mTextMiddle.text = "r"
        mTextLast.text = "you"
    }

    @IBAction func onCancelClickEvent(_ sender: UIButton) {
        exit(1)
    }
    
    @IBAction func onSaveClickEvent(_ sender: UIButton) {
        //mTextInfor.text = "U have a friend in me"
        mStringFirst = mTextFirst.text
        mStringMiddle = mTextMiddle.text
        mStringLast = mTextLast.text
        mTextInfor.text = mStringFirst + " " + mStringMiddle + " " + mStringLast
        let image = UIImage(named: "home")
        mImageHome.image = image
    }
    
    
    @IBAction func onDeleteClickEvent(_ sender: UIButton) {
        mTextInfor.text = ""
        mImageHome.image = nil
    }    
}

