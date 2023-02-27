

//import Foundation
//import UIKit
//
//class AsyncOperation: Operation {
//    override var isAsynchronous: Bool { return true }
//    override var isExecuting: Bool { return state == .executing }
//    override var isFinished: Bool { return state == .finished }
//
//    var state = State.ready {
//        willSet {
//            willChangeValue(forKey: state.keyPath)
//            willChangeValue(forKey: newValue.keyPath)
//        }
//        didSet {
//            didChangeValue(forKey: state.keyPath)
//            didChangeValue(forKey: oldValue.keyPath)
//        }
//    }
//
//    enum State: String {
//        case ready = "Ready"
//        case executing = "Executing"
//        case finished = "Finished"
//        fileprivate var keyPath: String { return "is" + self.rawValue }
//    }
//
//    override func start() {
//        if self.isCancelled {
//            state = .finished
//        } else {
//            state = .ready
//            main()
//        }
//    }
//
//    override func main() {
//        if self.isCancelled {
//            state = .finished
//        } else {
//            state = .executing
//        }
//    }
//}
//
//class DataLoaderOperation: AsyncOperation {
//    override func cancel() {
//        guard outputData == nil else {return}
//        dataTask?.cancel()
//        super.cancel()
//    }
//    
//    var request: URLRequest
//    var outputData: Data?
//    private var dataTask: URLSessionDataTask?
//    
//    init(request: URLRequest) {
//        self.request = request
//    }
//    
//    override func main() {
//        dataTask = URLSession.shared.dataTask(with: request) {
//            [weak self] data, _, _ in
//            self?.outputData = data
//            self?.state = .finished
//        }
//        dataTask?.resume()
//    }
//}
