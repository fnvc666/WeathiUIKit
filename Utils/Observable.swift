//
//  Observable.swift
//  Weathi
//
//  Created by on 09/03/2025.
//
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T?) -> Void) {
        listener = closure
        closure(value)
    }
}
