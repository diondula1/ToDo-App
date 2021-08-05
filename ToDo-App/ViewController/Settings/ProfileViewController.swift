//
//  ProfileViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 8/5/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "man")
        return imageView
    }()
    
    var stackView : UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: Design FullName
    
    var fullNameStackView : UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var fullNameLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Full Name:"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var fullNameTextField : UITextField = {
        var textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Dion Dula"
        return textField
    }()
    
    //MARK: Design UserName
    
    var userNameStackView : UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var userNameLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Username:"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    var userNameTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.text = "DionDula"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

extension ProfileViewController : ViewCode {
    func buildViewHierarchy() {
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(fullNameStackView)
        stackView.addArrangedSubview(userNameStackView)
        
        fullNameStackView.addArrangedSubview(fullNameLabel)
        fullNameStackView.addArrangedSubview(fullNameTextField)
        
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userNameTextField)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            
            fullNameStackView.heightAnchor.constraint(equalToConstant: 60),
            fullNameStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8),
            
            userNameStackView.heightAnchor.constraint(equalToConstant: 60),
            userNameStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.8)
        ])
        
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
    
}
