//
//  ProjectCell.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/14/21.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Day 1"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProjectTableViewCell : ViewCode {
    func buildViewHierarchy() {
        addSubview(cellView)
        cellView.addSubview(dayLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dayLabel.heightAnchor.constraint(equalTo: cellView.heightAnchor,constant: 20),
            dayLabel.widthAnchor.constraint(equalTo: cellView.widthAnchor,constant: 20),
            dayLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            dayLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
    }
    
    
}
