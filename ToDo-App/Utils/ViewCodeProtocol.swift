//
//  ViewCodeProtocol.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/22/21.
//

import Foundation


protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}

