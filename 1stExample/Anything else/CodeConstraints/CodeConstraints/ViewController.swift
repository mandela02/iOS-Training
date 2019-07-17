//
//  ViewController.swift
//  CodeConstraints
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mSafeArena: UIView!
    @IBOutlet weak var mButtonDown: UIButton!
    @IBOutlet weak var mImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //setConstraint()
    }
    
//    let mTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "I AM BATMAN"
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.textColor = .blue
//        return textView
//    }()

    let mTextView: UITextView = {
        let textView = UITextView()
        textView.text = "I AM BATMAN"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .blue
        //textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let mTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "I AM BATMAN"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .blue
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 50)
        return textLabel
    }()
    
    
    
    private func setConstraint()
    {
        
        //set contraints new textView
        
        mSafeArena.addSubview(mTextView)
        mTextView.centerXAnchor.constraint(equalTo: mSafeArena.centerXAnchor).isActive = true
        mTextView.centerYAnchor.constraint(equalTo: mSafeArena.centerYAnchor).isActive = true

        //view.backgroundColor = .red
        //mImage.isHidden = true
        //set constraint image view
        mImage.translatesAutoresizingMaskIntoConstraints = false
        mImage.topAnchor.constraint(equalTo: mSafeArena.topAnchor, constant: 100).isActive = true
        mImage.leadingAnchor.constraint(equalTo: mSafeArena.leadingAnchor, constant: 60).isActive = true
        mImage.widthAnchor.constraint(equalTo: mImage.heightAnchor).isActive = true
        mImage.centerXAnchor.constraint(equalTo: mSafeArena.centerXAnchor).isActive = true
    }
    

    @IBAction func buttonMoveUp(_ sender: Any) {
    }
    
    @IBAction func buttonMoveDown(_ sender: Any) {

    }
}

