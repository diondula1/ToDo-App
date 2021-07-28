//
//  ProjectController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit
import SimpleNetworkCall

class ProjectController: UIViewController {
    
    var list : [Project] = []
    var cellid = "cellid"
    
    //MARK: UI
    var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: cellid)
        
        setupView()
        callNetwork()
    }
    
    
    //MARK: NETWORK
    func callNetwork(){
        Network.shared.get(urlString: "".getProjectServerURL(), headerParameters: ["Authorization": UserDefaultsData.token]) { (results: Result<ReturnObject<[Project]>, Error>) in
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
    
  
    //MARK: ACTION
    @objc
    func addProjectAction(){
        let addProjectVC = AddProjectViewController()
        addProjectVC.didAddProject = {(project) in
            self.list.append(project)
            
            let addedIndexPath = IndexPath(item: self.list.count - 1, section: 0)

            self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
            self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        }
        self.navigationController?.present(addProjectVC, animated: true)
    }
    
}

//MARK: SetupView
extension ProjectController : ViewCode {
    func buildViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, landscapeImagePhone: .add, style: .plain, target: self, action: #selector(addProjectAction))
    }
}

//MARK: TableView
extension ProjectController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ProjectTableViewCell
        cell.dayLabel.text = list[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectSelected = list[indexPath.row]
        
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.scrollDirection = .horizontal
        collectionFlow.itemSize = CGSize.init(width: 333, height: 540)
        
        let boardVC = BoardCollectionViewController(collectionViewLayout: collectionFlow)
        boardVC.project = projectSelected
        boardVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boardVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



