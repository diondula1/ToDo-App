//
//  ProjectController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/8/21.
//

import UIKit
import SimpleNetworkCall

class ProjectController: UITableViewController {
    var list : [Project] = []
    var cellid = "cellid"
    
    override func viewDidLoad() {
        callNetwork()
        setTableView()
    }
    
    private func setTableView() {
        self.view.backgroundColor = .white
        tableView.separatorColor = .none
        tableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: cellid)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, landscapeImagePhone: .add, style: .plain, target: self, action: #selector(addProjectAction))
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

//MARK: TableView
extension ProjectController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ProjectTableViewCell
        cell.dayLabel.text = list[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectSelected = list[indexPath.row]
        
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.scrollDirection = .horizontal
        collectionFlow.itemSize = CGSize.init(width: 333, height: 540)
        
        let boardVC = BoardCollectionViewController(collectionViewLayout: collectionFlow)
        boardVC.project = projectSelected
        boardVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boardVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}



