//
//  ProjectCell.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/14/21.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    var card: Card?
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.FlatColor.Blue.Chambray
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.lightGray
        label.font = UIFont.boldSystemFont(ofSize: 9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
    }
    
    func initView(){
        dayLabel.text = card?.title
//        descriptionLabel.text = card?.cardDescription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: Card){
        self.card = data
        initView()
        
        if (card?.cardDescription != nil){
            descriptionLabel.isHidden = false
        }else{
            descriptionLabel.isHidden = true
        }
        setupView()
    }
    
    func setupView() {
        addSubview(cellView)
        addSubview(dayLabel)
//        addSubview(descriptionLabel)
        
        self.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            cellView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        dayLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 3).isActive = true
        dayLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -3).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 3).isActive = true
        //        dayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        //        if (card?.cardDescription != nil){
        //            descriptionLabel.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 1).isActive = true
        //            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3).isActive = true
        //            descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3).isActive = true
        //            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        //        }else{
        //            dayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3).isActive = true
        //        }
        
        
      
        
    }
    
    
}

