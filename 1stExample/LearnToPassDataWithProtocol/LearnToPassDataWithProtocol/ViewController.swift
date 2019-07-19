//
//  ViewController.swift
//  LearnToPassDataWithProtocol
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol sendMydataAndTakeBackDelegateProtocol: class {
    func sendData(myData: String) -> String
}

class ViewController: UIViewController {
    
    weak var delegate: sendMydataAndTakeBackDelegateProtocol? = nil

    
    @IBOutlet weak var datalabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDataSegue" {
            let secondVC: SecondViewController = segue.destination as! SecondViewController
            self.delegate = secondVC
            secondVC.delegate = self
            let data = self.delegate?.sendData(myData: "hello second View Controller")
            print(data ?? "haha same on you")
        }
    }
}

extension ViewController: giveBackDataToFirstVCDelegateProtocol {
    func giveBack(myData: String) {
        datalabel.text = myData
    }
}


