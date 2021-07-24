//
//  MainViewController.swift
//  DragAndDrop
//
//  Created by Alfian Losari on 1/5/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import MobileCoreServices
import SimpleNetworkCall


class BoardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let socket = SocketTodoManager()
    
    let constAddCellId = "constAddCellID"
    var categories : [Category] = []
    var project : Project?
    //    var category = [
    //        Category(id: "1", title: "Todo", cards: [Card(id: "1", title: "Database Migration"), Card(id: "1", title: "Schema Design"), Card(id: "1", title: "Schema Design")]),
    //        Category(id: "1", title: "In Progress", cards: [Card(id: "1", title: "Database Migration"), Card(id: "1", title: "Schema Design"), Card(id: "1", title: "Schema Design")]),
    //        Category(id: "1", title: "Done", cards: [Card(id: "1", title: "Database Migration"), Card(id: "1", title: "Schema Design"), Card(id: "1", title: "Schema Design")]),
    //    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        guard let project = project , let projectCategories = project.categories else {
            return
        }
        categories = projectCategories
        
        collectionView.backgroundColor = .white
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(BoardAddCollectionViewCell.self, forCellWithReuseIdentifier: constAddCellId)
        
        setupNavigationBar()
        updateCollectionViewItem(with: view.bounds.size)
        
        fetchNetworkData()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.stop()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupDelegates()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewItem(with: size)
    }
    
    
    
    //MARK: Setup
    func setupDelegates() {
        
        socket.delegate = self
        socket.projectId = project?.id
    }
    
    
    private func setupNavigationBar() {
        setupAddButtonItem()
    }
    
    func setupAddButtonItem() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    func setupRemoveBarButtonItem() {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addInteraction(UIDropInteraction(delegate: self))
        let removeBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = removeBarButtonItem
    }
    
    func setupAddBarButtonItem(addingType: AdingTypes) {
        let addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.red, for: .normal)
        let addBarButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        let cancelBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        
        switch addingType {
        case .Card:
            addButton.addTarget(self, action: #selector(addCardAction), for: .touchUpInside)
            cancelButton.addTarget(self, action: #selector(addCardAction), for: .touchUpInside)
        case .Category:
            addButton.addTarget(self, action: #selector(addCategoryAction), for: .touchUpInside)
            cancelButton.addTarget(self, action: #selector(cancelCategoryAction), for: .touchUpInside)
        }
        
    }
    
    
    private func updateCollectionViewItem(with size: CGSize) {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.itemSize = CGSize(width: size.width - 50, height: size.height * 0.8)
    }
    
    
    
    //MARK: Action
    @objc
    func addCategoryAction(){
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 1)) as! BoardAddCollectionViewCell
        
        guard let title = cell.titleTextField.text, !title.isEmpty else {
            return
        }
        
        postNetworkCategory(category: RequestCategory(Title: title))
        cancelCategoryAction()
    }
    
    @objc
    func cancelCategoryAction(){
        let cell = collectionView.cellForItem(at: IndexPath(row: 0, section: 1)) as! BoardAddCollectionViewCell
        
        self.navigationItem.leftBarButtonItem = nil
        cell.cancelAction()
        setupAddButtonItem()
    }
    
    @objc
    func addCardAction(){
        let cell = collectionView.cellForItem(at: IndexPath(row: 1, section: 0)) as! BoardCollectionViewCell
        
        let tableViewCell = cell.tableView.footerView(forSection: 0) as! CardTableViewFooterCell
        tableViewCell.addItem()
        //        postNetworkCard(card: RequestCard(Title: "dion"), categoryID: cell.category!.id)
        //        postNetworkCategory(category: RequestCategory(Title: title))
    }
    
    @objc
    func cancelCardAction(){
        _ = collectionView.cellForItem(at: IndexPath(row: 0, section: 1)) as! BoardCollectionViewCell
        
        self.navigationItem.leftBarButtonItem = nil
        //        cell.cancelAction()
        setupAddButtonItem()
    }
    
    private func addCategoryItem(category: Category) {
        self.categories.append(category)
        let addedIndexPath = IndexPath(item: self.categories.count - 1, section: 0)
        self.collectionView.insertItems(at: [addedIndexPath])
        self.collectionView.scrollToItem(at: addedIndexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        cancelCategoryAction()
        
    }
    
    //MARK: CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return categories.count
        }
        else{
            return 1
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BoardCollectionViewCell
            
            cell.setup(with: categories[indexPath.item], projectId: project!.id)
            cell.parentVC = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: constAddCellId, for: indexPath) as! BoardAddCollectionViewCell
            cell.parentVC = self
            return cell
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 15, bottom: 0, right: 15)
    }
    
    
}
//MARK: DropInteractionDelegate
extension BoardCollectionViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        session.loadObjects(ofClass: Card.self) { (items) in
            guard let _ = items.first as? Card else {
                return
            }
            
            if let (dataSource, sourceIndexPath, _) = session.localDragSession?.localContext as? (Category, IndexPath, UITableView) {
                self.deleteNetworkCard(projectId: self.project!.id, card: dataSource.cards[sourceIndexPath.row])
                
                //                tableView.beginUpdates()
                //                dataSource.cards.remove(at: sourceIndexPath.row)
                //                tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
                //                tableView.endUpdates()
            }
        }
    }
}

//MARK: Socket
extension BoardCollectionViewController : SocketCardManagerDelegate {
    
    
    
    func didConnect() {
        print("Connect To Room")
    }
    
    func didReceive(newCategory: Category) {
        self.categories.append(newCategory)
        self.collectionView.reloadData()
    }
    
    func didReceive(newCard: Card) {
        self.categories.first(where: {$0.id == newCard.categoryId})?.cards.append(newCard)
        self.collectionView.reloadData()
    }
    
    func didReceiveRemove(removeCard: Card) {
        print("Remove \(removeCard.categoryId)")
        self.categories.first(where: {$0.id == removeCard.categoryId})?.cards.removeAll(where: {$0.id == removeCard.id})
        self.collectionView.reloadData()
    }
    
    func didReceive(moveCard: ResponseMoveCard) {
        //        print("Remove \(moveCard.oldCardId)")
        self.categories.first(where: {$0.id == moveCard.oldCard.categoryId})?.cards.removeAll(where: {$0.id == moveCard.oldCard.id})
        self.categories.first(where: {$0.id == moveCard.newCard.categoryId})?.cards.append(moveCard.newCard)
        self.collectionView.reloadData()
    }
}


//MARK: Network
extension BoardCollectionViewController {
    
    func fetchNetworkData(){
        Network.shared.get(urlString:  "".getCardsURL(projectId: project!.id),headerParameters: ["Authorization": UserDefaultsData.token]) {  (results: Result<ReturnObject<[Card]>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if let data = data.data {
                        for i in self.categories.indices {
                            self.categories[i].cards = data.filter{ $0.categoryId == self.categories[i].id }
                        }
                        
                        self.collectionView.reloadData()
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
    
    
    func postNetworkCategory(category: RequestCategory){
        Network.shared.get(urlString: "".postCategoryURL(projectId: project!.id),headerParameters: ["Authorization": UserDefaultsData.token]) {  (results: Result<ReturnObject<Category>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if let _ = data.data {
                        //                        self.addCategoryItem(category: data)
                        //                        self.cancelCategoryAction()
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
    
    
    func deleteNetworkCard(projectId: String, card: Card){
        Network.shared.delete(urlString: "".deleteCardsURL(projectId: projectId, categoryId: card.categoryId, cardId: card.id),headerParameters: ["Authorization": UserDefaultsData.token])  { (results: Result<ReturnObject<Category>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if data.data != nil {
                        //Do Nothing wait from socket !!
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
    
    
    func postNetworkMoveCard(projectId: String, oldCard: Card, newCategoryId: String){
        
        Network.shared.post(body: oldCard, urlString: "".updateCardURL(projectId: projectId, categoryId: newCategoryId, newCategoryId: newCategoryId),headerParameters: ["Authorization": UserDefaultsData.token]) {  (results: Result<ReturnObject<Category>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if data.data != nil {
                        //Do Nothing wait from socket !!
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

public enum AdingTypes {
    case Category
    case Card
}
