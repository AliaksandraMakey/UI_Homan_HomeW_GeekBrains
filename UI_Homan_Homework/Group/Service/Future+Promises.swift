

import Foundation

class Future<Value> {
    
    typealias Result = Swift.Result<Value, Error>
    
    var result: Result? {
        didSet {result.map { report(result: $0) } }
    }
    private var callbacks = [(Result) -> Void]()
    func observe(using callback: @escaping (Result) -> Void) {
        if let result = result {
            return callback(result)
        }
        callbacks.append(callback)
    }
    
    private func report(result: Result) {
        callbacks.forEach { $0(result) }
        callbacks.removeAll()
    }
}

class Promise<Value>: Future<Value> {
    init(value: Value? = nil) {
        super.init()
        result = value.map( Result.success )
    }
    func result(with value: Value) {
        result = .success(value)
    }
    func reject(with error: Error) {
        result = .failure(error)
    }
}
