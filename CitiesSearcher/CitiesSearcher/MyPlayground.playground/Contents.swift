import UIKit
import RxSwift


var str = "Hello, playground"
let disposeBag = DisposeBag()
//var string = Observable.from([1,2,3,4,5,6,7,8,9,0])
//string.subscribe { event in
//    switch event {
//    case .next(let value):
//        print(value)
//    case .error(let err):
//        print(err)
//    case .completed:
//        print("completed")
//    }
//}.disposed(by: disposeBag)
//


//let sequenceA = Observable<Int>.of(1,2,3,4,5,6,7)
//let sequenceB = Observable<Int>.of(10,11,12,13,14,15,16)
//let sequenceAB = Observable.of(sequenceA, sequenceB)
//sequenceAB.flatMap {
//        return $0
//    }.subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
var publishSubject = PublishSubject<String>()
let subscription1 = publishSubject.subscribe(onNext:{
    print($0)
}).disposed(by: disposeBag)

publishSubject.onNext("Hello")
publishSubject.onNext("Again")

let subscription2 = publishSubject.subscribe(onNext:{
    print(#line,$0)
})
publishSubject.onNext("Both Subscriptions receive this message")



