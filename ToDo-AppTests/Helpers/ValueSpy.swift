//
//  ValueSpy.swift
//  ToDo-AppTests
//
//  Created by Dula Dion on 20/07/22.
//

import Combine

class ValuSpy<T> {
    var values: [T] = []
    var anyCancellable = Set<AnyCancellable>()
    
    init(_ publisher: AnyPublisher<T, Never>) {
        publisher.sink { [weak self] result in
            self?.values.append(result)
        }
        .store(in: &anyCancellable)
    }
}
