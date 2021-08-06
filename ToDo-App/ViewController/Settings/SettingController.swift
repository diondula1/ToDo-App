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
    var data  =
        [
            [
                SettingItem(name: "Language", image: UIImage(named: "language")!, settingType: .none),
                SettingItem(name: "Dark / Light", image: UIImage(systemName: "list.dash")!, settingType: .switch_),
            ],
            [
                SettingItem(name: "Profile", image: UIImage(systemName: "person.fill")!, settingType: .none),
                SettingItem(name: "Sign Out", image: UIImage(systemName: "list.dash")!, settingType: .none),
            ],
            [
                SettingItem(name: "Read Me", image: UIImage(systemName: "list.dash")!, settingType: .none),
                SettingItem(name: "Github", image: UIImage(named: "github")!, settingType: .none),
            ]
        ]
    
    let cellid = "cellid"
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
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
        let settingItem = data[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = settingItem.name
        cell.imageView?.image = settingItem.image
        cell.imageView?.image?.accessibilityFrame = CGRect(x: 0, y: 0, width: 20, height: 20)
        if settingItem.settingType == .switch_ {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.accessoryView = UISwitch()
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingItem = data[indexPath.section][indexPath.row]
        
        switch settingItem.name {
        case "Language":
            print("Language")
            
        case "Profile":
            navigationController?.pushViewController(ProfileViewController(), animated: true)
            
        case "Sign Out":
            logoutTapped()
            
        default:
            print("ADS")
        }
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
