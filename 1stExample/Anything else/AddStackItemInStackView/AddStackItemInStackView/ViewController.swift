//
//  ViewController.swift
//  AddStackItemInStackView
//
//  Created by mac on 7/8/19.
//  Copyright © 2019 CenterItemPagingCollectionView. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mStackView: UIStackView!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let insets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        mScrollView.contentInset = insets
        mScrollView.scrollIndicatorInsets = insets
    }
    
    

    @IBAction func addEntry(_ sender: Any) {
        let stack = mStackView
        var index: Int
        if stack?.arrangedSubviews != nil
        {
            index = stack!.arrangedSubviews.count - 1
        }
        else
        {
            index = 0
        }
        
        let addView = stack?.arrangedSubviews[index]
        
        let scroll = mScrollView
        let offset = CGPoint(x: scroll!.contentOffset.x, y: scroll!.contentOffset.y + addView!.frame.size.height)
        
        
        let newView = creatEntry()
        newView.isHidden = true
        stack?.insertArrangedSubview(newView, at: index)
        
        UIView.animate(withDuration: 0.35, animations: {
            () -> Void in
                newView.isHidden = false
                scroll?.contentOffset = offset
            })
    }
    
    @objc func deleteStack(sender: UIButton) {
        if let view = sender.superview
            
        {
            UIView.animate(withDuration: 0.25, animations: {
                () -> Void in
                view.isHidden = true
            }, completion:{
                (true) -> Void in
                view.removeFromSuperview()
                })
        }
    }
    
    private func creatEntry() -> UIView{
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let number = "\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())-\(randomHexQuad())"
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 10
        
        let dateLaber = UILabel()
        dateLaber.text = date
        dateLaber.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        
        let numberLaber = UILabel()
        numberLaber.text = number
        numberLaber.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        let deleteButton = UIButton(type: UIButton.ButtonType.roundedRect)
        deleteButton.setTitle("Delete", for: UIControl.State.normal)
        deleteButton.addTarget(self, action: #selector(deleteStack), for: .touchUpInside)

        stack.addArrangedSubview(dateLaber)
        stack.addArrangedSubview(numberLaber)
        stack.addArrangedSubview(deleteButton)
        
        return stack
    }
    
    private func randomHexQuad() -> String {
        return NSString(format: "%X%X%X%X",
                        arc4random() % 16,
                        arc4random() % 16,
                        arc4random() % 16,
                        arc4random() % 16
            ) as String
    }
    
}

