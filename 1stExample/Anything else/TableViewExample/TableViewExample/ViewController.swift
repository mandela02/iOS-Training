//
//  ViewController.swift
//  TableViewExample
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var mSecretIdentity: UITextField?
    @IBOutlet weak var mHeroName: UITextField?
    @IBOutlet weak var mSaveButton: UIBarButtonItem!
    @IBOutlet weak var mCancelButton: UIBarButtonItem!
    
    var hero: HeroName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mSecretIdentity?.delegate = self
        mHeroName?.delegate = self
    }
    
    @IBAction func mSaveAction(_ sender: Any) {
    }
    
    @IBAction func mCancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === mSaveButton
        else
        {
            return
        }
        hero = HeroName(RealName: mSecretIdentity!.text!, HeroName: mHeroName!.text!)
        
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = mSecretIdentity!.text ?? ""
        mSaveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mSaveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //updateSaveButtonState()
        mSaveButton.isEnabled = true
    }


}

