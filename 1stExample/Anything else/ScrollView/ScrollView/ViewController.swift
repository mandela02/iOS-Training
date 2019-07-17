//
//  ViewController.swift
//  ScrollView
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mStackView: UIStackView!
    @IBOutlet weak var mScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initScroll()
    }
    
    private func initScroll()
    {
        let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        mScrollView.contentInset = insets
        mScrollView.scrollIndicatorInsets = insets
        mScrollView.backgroundColor = .yellow
    }
    
    @ objc func deleteStackItem(sender: UIButton)  {
        if let view = sender.superview
        {
        view.removeFromSuperview()
        }
    }
    func createNewEntry() -> UIView {
        //let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let date = "Abc"
        let number = "wqwersdfsdfsdftyui"
        
        //let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 8
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        //dateLabel.isScrollEnabled = false
        //dateLabel.isEditable = false
        //dateLabel.textContainerInset = inset
        dateLabel.backgroundColor = .red
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        //numberLabel.isScrollEnabled = false
        //numberLabel.isEditable = false
        //numberLabel.textContainerInset = inset
        numberLabel.backgroundColor = .red

        let button = UIButton()
        button.setTitle("Delete", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(deleteStackItem(sender:)), for: .touchUpInside)
        button.backgroundColor = .black
        //button.contentEdgeInsets = inset
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(button)
        
        button.setContentHuggingPriority(UILayoutPriority.init(750), for: .horizontal)
        dateLabel.setContentHuggingPriority(UILayoutPriority.init(751), for: .horizontal)
        numberLabel.setContentHuggingPriority(UILayoutPriority.init(749), for: .horizontal)
        
        button.setContentCompressionResistancePriority(UILayoutPriority.init(750),for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(UILayoutPriority.init(750),for: .horizontal)
        numberLabel.setContentCompressionResistancePriority(UILayoutPriority.init(749),for: .horizontal)
        
        
        button.heightAnchor.constraint(equalTo: dateLabel.heightAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true


        return stack
    }

    @IBAction func addButtonEvent(_ sender: Any) {
        
        let stack = mStackView
        let index = stack!.arrangedSubviews.count - 1
        
        let newView = createNewEntry()
        stack?.insertArrangedSubview(newView, at: index)
        
    }
}

