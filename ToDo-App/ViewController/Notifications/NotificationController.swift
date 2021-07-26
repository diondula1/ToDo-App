//
//  Notification.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit
import SimpleNetworkCall

class NotificationController: UIViewController {
    
    var list : [NotificationResponse] = []
    let cellid = "cellid"
    
    var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .none
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80.0;
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: cellid)
        
        setupView()
        setupObserves()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.removeBadge(index: 1)
    }
    
    private func setupObserves(){
        NotificationCenter.default.addObserver(self, selector: #selector(addNotificationAction), name: .didAddNotification, object: nil)
    }
    
    private func removeObserves(){
        NotificationCenter.default.removeObserver(self,  name: .didAddNotification, object: nil)
    }
    //MARK: Action
    @objc
    func addNotificationAction(_ notification: Notification){
        
        let object = notification.object as? [String: String] ?? [:]
        if let id = object["id"] , let messageDescription = object["description"], let projectTitle = object["projectName"], let date = object["date"]{
            
            let notification = NotificationResponse(id: id, messageDescription: messageDescription, project: Project(id: "", title: projectTitle), date: date)
            
            self.list.insert(notification, at: 0)
            self.tableView.reloadData()
        }
    }
    
    deinit {
        removeObserves()
    }
}

//MARK: SetupView
extension NotificationController : ViewCode {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        
    }
}

//MARK: TableView
extension NotificationController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! NotificationTableViewCell
        cell.setup(with: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
}

//MARK: Network
extension NotificationController {
    func fetchData(){
        
        Network.shared.get(urlString: "".getNotificationServerURL(projectId: "all"),headerParameters: ["Authorization": UserDefaultsData.token]) { (results: Result<ReturnObject<[NotificationResponse]>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if let data = data.data {
                        self.list = data
                        self.tableView.reloadData()
                    }else{
                        self.showAlert(alertText: "Something went wrong !!", alertMessage: "Server Error!!.")
                    }
                }else{
                    self.showAlert(alertText: "Server Error!", alertMessage: data.message)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}

