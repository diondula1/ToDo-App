//
//  TaskCustomHeaderCell.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/27/21.
//

import UIKit


class CardTableViewFooterCell: UITableViewHeaderFooterView {
    
    weak var tableView : BoardCollectionViewCell?
    var section: Int?
    
    let addButton : UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Card", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        
        contentView.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        addButton.addTarget(self, action: #selector(addBoardAction), for: .touchUpInside)
    }
    
    func addItem(){
//        tableView?.addItem(addItem: "dion")
    }
    
    @objc
    func addBoardAction(){
//        print("Section \(String(describing: section))")
        tableView?.addAction()
//        tableView?.parentVC?.setupAddBarButtonItem(addingType: .Card)
    }
    
    
    
}
