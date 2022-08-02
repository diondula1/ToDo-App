//
//  EmptyView.swift
//  ToDo-App
//
//  Created by Dion Dula on 8/2/22.
//
import UIKit

class ErrorRetryView: UIView {
    var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "man")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var errorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonRetry: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .selected)
        button.backgroundColor = UIColor.systemGreen
        button.target(forAction: #selector(retryAction), withSender: ErrorRetryView.self)
        return button
    }()
    
    var retryCallBack: (() -> ()) = {}
    
    @objc
    private func retryAction() {
        retryCallBack()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorRetryView: ViewCode {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(errorLabel)
        addSubview(buttonRetry)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            errorLabel.widthAnchor.constraint(equalToConstant: 200),
            errorLabel.heightAnchor.constraint(equalToConstant: 200),
            errorLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonRetry.widthAnchor.constraint(equalToConstant: 200),
            buttonRetry.heightAnchor.constraint(equalToConstant: 200),
            buttonRetry.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 20),
            buttonRetry.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .red
    }
}
