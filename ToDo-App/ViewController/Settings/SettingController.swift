//
//  SettingController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit

class SettingController: UIViewController {
    
    //MARK: UI-Elements
    var tableView : UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    var sections = ["Common", "Account", "About"]
    var data  = [[ "Language" , "Dark / Light" ], [ "Profile" , "Sign Out" ], [ "Read Me" , "Github" ]]
    
    let cellid = "cellid"
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutTapped))
        
        setupView()
        
        
    }
    
    @objc
    func logoutTapped(){
        UserDefaultsData.token = ""
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}


extension SettingController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellid)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(systemName: "list.dash")
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//        var sw = UISwitch()
//        sw.action
        cell.accessoryView = UISwitch()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("SDasD")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}


//MARK: SetupView
extension SettingController : ViewCode {
    func setupView() {
        
    }
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}


struct Setting {
    var name : String
    
}
