private struct NopDisposable : Disposable {
 
    fileprivate static let noOp: Disposable = NopDisposable()
    
    private init() {
        
    }
    
    /// Does nothing.
    public func dispose() {
    }
}

extension Disposables {
    /**
     Creates a disposable that does nothing on disposal.
     */
    static public func create() -> Disposable {
        return NopDisposable.noOp
    }
}
