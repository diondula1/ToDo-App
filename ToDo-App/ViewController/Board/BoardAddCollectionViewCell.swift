//
//  BoardAddCollectionViewCell.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/16/21.
//

import UIKit

class BoardAddCollectionViewCell: UICollectionViewCell {
    
    let titleTextField : UITextField = {
        var textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.sizeToFit()
        textfield.textColor = .white
     
        let placeholderText = NSAttributedString(string: "List Name",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.FlatColor.Gray.Iron])
               
        textfield.attributedPlaceholder = placeholderText
        textfield.setLeftPaddingPoints(8)
        textfield.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 6
        return textfield
    }()
    
    let addButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add List", for: .normal)
        button.titleLabel?.tintColor = .white
        button.sizeToFit()
        button.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    weak var parentVC: BoardCollectionViewController?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.autoresizesSubviews = true
        contentView.addSubview(titleTextField)
        contentView.addSubview(addButton)
        
        titleTextField.isHidden = true
        configureContents()
        
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        
        NSLayoutConstraint.activate([
            
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: self.topAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    //MARK: Aaction
    @objc
    func addAction(){
        parentVC?.setupAddBarButtonItem(addingType: .Category)
        addButton.isHidden = true
        titleTextField.isHidden = false
        titleTextField.becomeFirstResponder()
    }
    
    
    func cancelAction(){
        addButton.isHidden = false
        titleTextField.isHidden = true
        titleTextField.text = ""
    }
}


