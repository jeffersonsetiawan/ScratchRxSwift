/// To wrap because `Thread.setThreadLocalStorageValue(newValue, forKey: CurrentThreadSchedulerQueueKey.instance)`, need the value to be class
final class RxMutableBox<T>: CustomDebugStringConvertible {
    /// Wrapped value
    var value: T
    
    /// Creates reference wrapper for `value`.
    ///
    /// - parameter value: Value to wrap.
    init (_ value: T) {
        self.value = value
    }
}

extension RxMutableBox {
    /// - returns: Box description.
    var debugDescription: String {
        return "MutatingBox(\(self.value))"
    }
}
