//
//  ViewModel.swift
//  learnRxSwiftWithStyle
//
//  Created by mac on 8/5/19.
//  Copyright © 2019 Bui Quang Tri. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class ViewModel {
    static let shared = ViewModel()
    
    private init() {
    }
    
    var friendsList = [Friend(name: "Batman", number: "1123123123"),
                       Friend(name: "Superman", number: "2123134"),
                       Friend(name: "Wonder Woman", number: "3134134")]
    public var filterFriendsList: [Friend] = []
    public var friends: BehaviorRelay<[Friend]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    
    public func requestData() {
        friends.accept(friendsList)
        friends
            .asObservable()
            .subscribe(onNext: { Friends in
            })
            .disposed(by: disposeBag)
    }
    
    public var selectedFriend: BehaviorRelay<Friend> = BehaviorRelay(value: Friend(name: "", number: ""))
    
    var isSelected: Observable<Bool> {
        return selectedFriend.asObservable().map{ $0.name != "" }
    }

    public func setNil() {
        selectedFriend.accept(Friend(name: "", number: ""))
    }
    
    public func updateFriend() {
        guard let index = friendsList.index(where: {$0 === selectedFriend.value}) else {
            return
        }
        print(index)
        friendsList[index].name = self.nameText.value
        friendsList[index].number = self.numberText.value
        friends.accept(friendsList)
    }
    
    public func addData() {
        let friend = Friend(name: nameText.value,
                            number: numberText.value)
        friendsList.append(friend)
        friends.accept(friendsList)
    }

    public func search(query: String) {
        filterFriendsList = friendsList.filter({$0.name.hasPrefix(query)})
        friends.accept(filterFriendsList)
    }
    
    var nameText = BehaviorRelay<String>(value: "")
    var numberText = BehaviorRelay<String>(value: "")
    
    var isNameValid: Observable<Bool> {
        return nameText.asObservable().map {$0.count > 3}
    }
    
    var isNumberValid: Observable<Bool> {
        return numberText.asObservable().map {$0.count > 3}
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isNameValid,
                                        isNumberValid,
                                        resultSelector: {$0 && $1})
    }
}
