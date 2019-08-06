//
//  AddFriendViewController.swift
//  learnRxSwiftWithStyle
//
//  Created by mac on 8/6/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddFriendViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    var isSelected = false
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
        checkValidFriendInformation()
        setButton()
    }
    
    func checkValidFriendInformation() {
        nameTextField.rx.text.map { $0 ?? "" }.bind(to: ViewModel.shared.nameText).disposed(by: disposeBag)
        numberTextField.rx.text.map { $0 ?? "" }.bind(to: ViewModel.shared.numberText).disposed(by: disposeBag)
        ViewModel.shared.isValid.bind(to: addButton.rx.isEnabled).disposed(by: disposeBag)
        ViewModel.shared.isValid.subscribe { isValid in
        }.disposed(by: disposeBag)
    }
    
    func setUpTextField() {
        ViewModel.shared.isSelected.subscribe(onNext: { [unowned self] isSelected in
            if isSelected == true {
                self.isSelected = true
                self.nameTextField.text = ViewModel.shared.selectedFriend.value.name
                self.numberTextField.text = ViewModel.shared.selectedFriend.value.number
            }
        }).disposed(by: disposeBag)

        ViewModel.shared.isNameValid.subscribe(onNext: { [unowned self] (isValid) in
            self.nameTextField.setValidBackgroud(isValid)
        }).disposed(by: disposeBag)
        
        ViewModel.shared.isNumberValid.subscribe(onNext: { [unowned self] (isValid) in
            self.numberTextField.setValidBackgroud(isValid)
        }).disposed(by: disposeBag)
    }
    
    private func setButton() {
        if isSelected {
            addButton.rx.tap
                .bind(onNext: ViewModel.shared.updateFriend)
                .disposed(by: disposeBag)
        }
        else {
            addButton.rx.tap
                .bind(onNext: ViewModel.shared.addData)
                .disposed(by: disposeBag)
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        dismiss(animated: true) {
            ViewModel.shared.setNil()
        }
    }
}

extension UITextField {
    func setValidBackgroud (_ isValid: Bool) {
        if !isValid {
            self.backgroundColor = .red
        }
        else {
            self.backgroundColor = .white
        }
    }
}
