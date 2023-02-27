import Foundation
import UIKit

extension Future {
    func map<T> (using closure: @escaping (Value) throws -> Future<T>) -> Future<T> {
        let promise = Promise<T>()
        
        observe { result in
            switch result {
            case.success(let value):
                do {
                    let future = try closure(value)
                    future.observe { result in
                        switch result {
                        case .success(let value):
                            promise.result(with: value)
                        case .failure(let error):
                            promise.reject(with: error)
                        }
                    }
                } catch {
                    promise.reject(with: error)
                }
            case .failure(let error):
                promise.reject(with: error)
            }
        }
        return promise
    }
    
    func compactMap<T>(using closure: @escaping (Value) throws -> Future<T>?) -> Future<T> {
        let promise = Promise<T>()
        
        observe { result in
            do {
                let value = try result.get()
                let future = try closure(value)
                
                future?.observe { (result: Swift.Result<T, Error>) in
                    do {
                        let value = try result.get()
                        promise.result(with: value)
                    } catch {
                        promise.reject(with: error)
                    }
                }
            } catch {
                promise.reject(with: error)
            }
        }
        return promise
    }
}
