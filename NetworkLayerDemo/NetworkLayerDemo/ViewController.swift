//
//  ViewController.swift
//  NetworkLayerDemo
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiClient.getPosts(userId: 1, id: 2)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { postsList in
                postsList.forEach({ post in
                    print(post)
                })
            }, onError: { error in
                switch error {
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    print("Forbidden error")
                case ApiError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
}

