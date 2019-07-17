//
//  ViewController.swift
//  PickerView
//
//  Created by mac on 7/12/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heroPicker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    var name = ["The Lone Wanderer", "The Sole Survival", "The Courier 6", "The Choosen One", "The Vault Dweller"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        heroPicker.dataSource = self
        heroPicker.delegate = self
    }


    @IBAction func buttonChooseHeroPress(_ sender: Any) {
        heroPicker.isHidden = false
    }
}

extension ViewController: UIPickerViewDelegate {

}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return name.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        button.setTitle(name[row], for: .normal)
        heroPicker.isHidden = true
    }
}

