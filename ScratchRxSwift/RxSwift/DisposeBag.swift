//
//  DisposeBag.swift
//  ScratchRxSwift
//
//  Created by Jefferson Setiawan on 22/10/21.
//

public final class DisposeBag: DisposeBase {
    
    private var _lock = SpinLock()
    
    // state
    private var _disposables = [Disposable]()
    private var _isDisposed = false
    
    /// Constructs new empty dispose bag.
    public override init() {
        super.init()
    }

    /// Adds `disposable` to be disposed when dispose bag is being deinited.
    ///
    /// - parameter disposable: Disposable to add.
    public func insert(_ disposable: Disposable) {
        self._insert(disposable)?.dispose()
    }
    
    private func _insert(_ disposable: Disposable) -> Disposable? {
        self._lock.lock(); defer { self._lock.unlock() }
        if self._isDisposed {
            return disposable
        }

        self._disposables.append(disposable)

        return nil
    }

    /// This is internal on purpose, take a look at `CompositeDisposable` instead.
    private func dispose() {
        let oldDisposables = self._dispose()

        for disposable in oldDisposables {
            disposable.dispose()
        }
    }

    private func _dispose() -> [Disposable] {
        self._lock.lock(); defer { self._lock.unlock() }

        let disposables = self._disposables
        
        self._disposables.removeAll(keepingCapacity: false)
        self._isDisposed = true
        
        return disposables
    }
    
    deinit {
        self.dispose()
    }
}

extension Disposable {
    /// Adds `self` to `bag`
    ///
    /// - parameter bag: `DisposeBag` to add `self` to.
    public func disposed(by bag: DisposeBag) {
        bag.insert(self)
    }
}
