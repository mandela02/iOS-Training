//
//  SecondViewController.swift
//  LearnToPassDataWithProtocol
//
//  Created by mac on 7/19/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

protocol giveBackDataToFirstVCDelegateProtocol: class {
    func giveBack(myData: String)
}

class SecondViewController: UIViewController, sendMydataAndTakeBackDelegateProtocol{
    @IBOutlet weak var getDataTextField: UITextField!
    @IBOutlet weak var receivedDataLabel: UILabel!
    
    var dataReceivedFromFirstVC: String? = nil
    var dataSendFromThisVC: String? = nil
    
    weak var delegate: giveBackDataToFirstVCDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivedDataLabel.text = dataReceivedFromFirstVC
    }
    
    
    @IBAction func sendDataToFirstViewControllerEvent(_ sender: Any) {
        if delegate != nil
        {
            delegate?.giveBack(myData: getDataTextField.text ?? "you have nothing")
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    func sendData(myData: String) -> String {
        print(myData)
        dataReceivedFromFirstVC = myData
        return dataSendFromThisVC ?? "you have nothing"
    }
}
