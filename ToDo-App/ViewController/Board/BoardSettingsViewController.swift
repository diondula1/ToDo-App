//
//  BoardSettingsViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 8/2/21.
//

import UIKit

class BoardSettingsViewController: UIViewController {
    
    var itemArray =
        [
            SettingItem(name: "About this board", image: UIImage(systemName: "info.circle")!),
            SettingItem(name: "Members", image: UIImage(systemName: "person.fill")!),
            SettingItem(name: "Activity", image: UIImage(systemName: "list.bullet")!),
        ]

    
    var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: Action
    @objc
    func dismissAction(){
        dismiss(animated: true, completion: nil)
    }
}

//MARK: SetupView
extension BoardSettingsViewController : ViewCode {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(dismissAction))
    }
}


//MARK: TableView
extension BoardSettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "asd")
        cell.textLabel?.text = itemArray[indexPath.row].name
        cell.accessoryView = UIImageView(image: itemArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

