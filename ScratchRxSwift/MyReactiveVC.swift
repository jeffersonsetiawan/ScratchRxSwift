//
//  MyReactiveVC.swift
//  ScratchRxSwift
//
//  Created by Jefferson Setiawan on 22/10/21.
//

import UIKit

final class MyReactiveVC: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ReactiveVC"
        view.backgroundColor = .white
        testAtomic()
        
        let intObservable = Observable<Int>.create { observer in
            observer.onNext(0)
            var a = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                observer.onNext(100)
            }
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                a += 1
                print("<<< TIMER tick \(a)")
                observer.onNext(a)
                if a == 3 {
                    observer.onCompleted()
                }
            }

            return Disposables.create {
                print("<<< Cleaning intObservable")
                timer.invalidate()
            }
        }
        
        intObservable.subscribe(MyCustomObserver()).disposed(by: disposeBag)
//        intObservable.subscribe { event in
//            switch event {
//            case let .next(value): print(value)
//            case let .error(error): break
//            case .completed: break
//            }
//        }
//        .disposed(by: disposeBag)
        intObservable.subscribe(
            onNext: { number in
                print("> \(Date()) \(number)")
            },
            onDisposed: {
                print("> Disposed")
            })
            .disposed(by: disposeBag)
    }
    
    private func testAtomic() {
        let atom = AtomicInt(3)
        print("<<< isFlagSet0 ", isFlagSet(atom, 0))
        let prev = fetchOr(atom, 1)
        print("<<< isFlagSet0FetchOr ", isFlagSet(atom, 0), atom.description, prev)
        let atom1 = AtomicInt(1)
        print("<<< isFlagSet1 ", isFlagSet(atom1, 0))
        /*
         010 = 2
         001 = 1
         
         011 = 3
         */
        
        /*
         000 = 0
         001 = 1
         010 = 2
         011 = 3
         100 = 4
         101 = 5
         110 = 6
         111 = 7
         */
    }
}


class MyCustomObserver<Element>: ObserverType {
    init() {}
    func on(_ event: Event<Element>) {
        print("> ", event)
    }
    deinit {
        print(">> DEINIT")
    }
}
