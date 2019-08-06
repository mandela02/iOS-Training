//
//  SearchViewController.swift
//  FlowerForever
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        searchButton.layer.cornerRadius = 10
        searchTextField.delegate = self
        if (searchTextField.text?.isEmpty)! {
            searchButton.isEnabled = false
        }
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? UINavigationController else {
//            fatalError()
//        }
//        let tableController = destination.topViewController
        ImagesAPI.shared.images.removeAll()
        Const.shared.queueKey = getKeyword()
    }

    func getKeyword() -> String {
        guard let keyWord = searchTextField.text else {
            return "Girl"
        }
        let newString = keyWord.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        print(newString)
        return newString
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField.text as NSString? else {
            fatalError()
        }
        let text = textField.replacingCharacters(in: range, with: string)
        if !text.isEmpty {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
        return true
    }
}
