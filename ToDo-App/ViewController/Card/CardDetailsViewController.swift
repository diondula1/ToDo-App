//
//  CardDetailsViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/21/21.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    var card : Card?
    
    var titleTextField: UITextField = {
       var textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    var descriptionTextField: UITextField = {
       var textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    //TODO: MAKE it view insted button
    var colorButton : UIButton = {
        var view = UIButton()
        view.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var dataPicket : UIDatePicker = {
        var dataPicket = UIDatePicker()
        dataPicket.translatesAutoresizingMaskIntoConstraints = false
        return dataPicket
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        colorButton.addTarget(self, action: #selector(changeColorAction), for: .touchUpInside)
        setupView()
    }
    
    //MARK: Action
    @objc
    func changeColorAction(){
        let picker = UIColorPickerViewController()
        picker.selectedColor = self.colorButton.backgroundColor!
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func updateCard(){
        
    }
}

//MARK: SetupView
extension CardDetailsViewController : ViewCode {
    func buildViewHierarchy() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(colorButton)
        view.addSubview(dataPicket)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            
            descriptionTextField.topAnchor.constraint(equalTo: self.titleTextField.bottomAnchor,constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            
            colorButton.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor,constant: 20),
            colorButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            colorButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
            
            dataPicket.topAnchor.constraint(equalTo: self.colorButton.bottomAnchor,constant: 20),
            dataPicket.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            dataPicket.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        titleTextField.text = card?.title
        descriptionTextField.text = card?.cardDescription
    }
    
    
}


extension CardDetailsViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorButton.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorButton.backgroundColor = viewController.selectedColor
    }
}
