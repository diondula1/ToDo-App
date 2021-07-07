//
//  NotificationTableViewCell.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/22/21.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    //MARK: UI-Elements
    lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(12)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        label.sizeToFit()
        return label
    }()
    
    var projectLabel : UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(9)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    //MARK: Setup
    func setup(with notification: NotificationResponse){
        messageLabel.text = notification.messageDescription
        projectLabel.text = notification.project.title
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date: Date? = dateFormatterGet.date(from: notification.date)
        dateLabel.text = date?.getFormattedDate(format: "yyy-MM-dd HH:mm")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension NotificationTableViewCell : ViewCode {
  
    func buildViewHierarchy() {
        self.addSubview(cellView)
        cellView.addSubview(messageLabel)
        cellView.addSubview(projectLabel)
        cellView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            projectLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            projectLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 16),
            projectLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            projectLabel.heightAnchor.constraint(equalToConstant: 20),
            
            messageLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -6),
            messageLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 16),
            messageLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -6),
            
            dateLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8),
            dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        cellView.backgroundColor = UIColor.FlatColor.Gray.WhiteSmoke
    }
    
    
}

