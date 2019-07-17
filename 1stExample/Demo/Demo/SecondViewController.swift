//
//  SecondViewController.swift
//  Demo
//
//  Created by mac on 7/10/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mStackView: UIStackView!
    @IBOutlet var mView: UIView!

    var count = 0
    
    let mTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "The American Dream"
        textLabel.textColor = .blue
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 25)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScroll()
        addView()
    }
    
    private func addView() {
        //mStackView.insertArrangedSubview(mTextLabel, at: 0)
        mView.addSubview(mTextLabel)
        mTextLabel.centerXAnchor.constraint(equalTo: mView.centerXAnchor).isActive = true
        mTextLabel.centerYAnchor.constraint(equalTo: mView.centerYAnchor).isActive = true
        
    }
    
    private func initScroll() {
        let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        mScrollView.contentInset = insets
        mScrollView.scrollIndicatorInsets = insets
        mScrollView.backgroundColor = .white
    }
    
    @objc func deleteStackItem(sender: UIButton)  {
        if let view = sender.superview {
            view.removeFromSuperview()
        }
    }
    
    
    func createNewEntry() -> UIView {
        //let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let date = "23/10/2077"
        let number = "The Great War bombs: + \(count)"
        
        count += 1
    
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dateLabel.backgroundColor = .red
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    
        let textLabel = UILabel()
        textLabel.text = number
        textLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        textLabel.backgroundColor = .blue
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.addTarget(self, action: #selector(deleteStackItem(sender:)), for: .touchUpInside)
        button.backgroundColor = .yellow
        button.contentEdgeInsets = inset
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(textLabel)
        stack.addArrangedSubview(button)
        
        button.setContentHuggingPriority(.init(752), for: .horizontal)
        dateLabel.setContentHuggingPriority(.init(751), for: .horizontal)
        textLabel.setContentHuggingPriority(.init(750), for: .horizontal)
        
        button.setContentCompressionResistancePriority(.init(752),for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.init(751),for: .horizontal)
        textLabel.setContentCompressionResistancePriority(.init(750),for: .horizontal)
        
        button.heightAnchor.constraint(equalTo: dateLabel.heightAnchor).isActive = true
        textLabel.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        
        return stack
    }
    
    @IBAction func addButtonEvent(_ sender: Any) {
        let stack = mStackView
        let index = stack!.arrangedSubviews.count - 1
        
        let newView = createNewEntry()
        stack?.insertArrangedSubview(newView, at: index)
    }
}

