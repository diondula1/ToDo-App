//
//  ItemCollectionViewCell.swift
//  DragAndDrop
//
//  Created by Alfian Losari on 1/6/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import MobileCoreServices
import SimpleNetworkCall

class BoardCollectionViewCell: UICollectionViewCell {
    let headercellid = "headercellid"
    let cellid = "cellid"
    let footercellid = "footercellid"
    
    let constHeaderHeight : CGFloat = 40
    let constCellHeight : CGFloat = 80
    let constFooterHeight : CGFloat = 40
    
    var tableViewHeightConstraint : NSLayoutConstraint?
    
    var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        return tableView
    }()
    
    weak var parentVC: BoardCollectionViewController?
    var category: Category?
    var projectId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CardTableViewHeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: headercellid)
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.register(CardTableViewFooterCell.self, forHeaderFooterViewReuseIdentifier: footercellid)
        self.tableView.layer.masksToBounds = true
        self.tableView.layer.cornerRadius = 6
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        setupView()
    }
    
    func setupView(){
        self.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        self.autoresizesSubviews = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setup(with data: Category, projectId: String) {
        self.category = data
        self.projectId = projectId
        tableView.reloadData()
    }
    
    func addItem(card : Card) {
        guard let category = self.category else {
            return
        }
        
        category.cards.append(card)
        
        let addedIndexPath = IndexPath(item: category.cards.count - 1, section: 0)

        self.tableView.insertRows(at: [addedIndexPath], with: .automatic)
        self.tableView.scrollToRow(at: addedIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }

    func postNetworkCard(card: RequestCard,categoryID: String){
        Network.shared.post(body: card, urlString: "".postCardsURL(projectId: projectId!, categoryId: categoryID)) {  (results: Result<ReturnObject<Card>, Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if let _ = data.data {
                       // self.addItem(card: data)
                    }else{
                        self.parentVC?.showAlert(alertText: "Something went wrong !!", alertMessage: "Server Error!!.")
                    }
                }else{
                    self.parentVC?.showAlert(alertText: "Server Error!", alertMessage: data.message)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    func addAction() {
        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, !text.isEmpty else {
                return
            }
            
            guard let category = self.category else {
                return
            }
            self.postNetworkCard(card: RequestCard(Title: text), categoryID: category.id)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        parentVC?.present(alertController, animated: true, completion: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: TableView
extension BoardCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: HEADER
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                headercellid) as! CardTableViewHeaderCell
        
        view.titleLabel.text = category?.title
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return constHeaderHeight
    }
    
    //MARK: FOOTER
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                footercellid) as! CardTableViewFooterCell
        
        view.tableView = self
        view.section = section
        print(section)
        return view
    }
    
    

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return constFooterHeight
    }
    
    //MARK: TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.cards.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! CardTableViewCell
        guard let card = category?.cards[indexPath.row] else {
            return cell
        }
        
        cell.setup(with: card)
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let boardVC = CardDetailsViewController()
        boardVC.card = category?.cards[indexPath.row]
        self.parentVC?.navigationController?.present(boardVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BoardCollectionViewCell: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let board = category, let card = category?.cards[indexPath.row]  else {
            return []
        }
        
        
        let itemProvider = NSItemProvider(object: card)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        session.localContext = (board, indexPath, tableView)
        print("DRAG: ")
        print(card)
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionWillBegin session: UIDragSession) {
        self.parentVC?.setupRemoveBarButtonItem()
        self.parentVC?.navigationItem.rightBarButtonItem = nil
    }
    
    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        self.parentVC?.setupAddButtonItem()
        self.parentVC?.navigationItem.leftBarButtonItem = nil
    }
    
}

extension BoardCollectionViewCell: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {

            coordinator.session.loadObjects(ofClass: Card.self) { (items) in

                guard let _ = items.first as? Card else {
                    return
                }

                switch (coordinator.items.first?.sourceIndexPath, coordinator.destinationIndexPath) {
                case (.some(let sourceIndexPath), .some(let destinationIndexPath)):
                    // Same Table View
//                    let updatedIndexPaths: [IndexPath]
//                    if sourceIndexPath.row < destinationIndexPath.row {
//                        updatedIndexPaths =  (sourceIndexPath.row...destinationIndexPath.row).map { IndexPath(row: $0, section: 0) }
//                    } else if sourceIndexPath.row > destinationIndexPath.row {
//                        updatedIndexPaths =  (destinationIndexPath.row...sourceIndexPath.row).map { IndexPath(row: $0, section: 0) }
//                    } else {
//                        updatedIndexPaths = []
//                    }
//                    self.tableView.beginUpdates()
//                    self.category?.cards.remove(at: sourceIndexPath.row)
//                    self.category?.cards.insert(card, at: destinationIndexPath.row)
//                    self.tableView.reloadRows(at: updatedIndexPaths, with: .automatic)
//                    self.tableView.endUpdates()
                    
                    break
                case (nil, .some(let destinationIndexPath)):
                    // Move data from a table to another table
//                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
//                    self.tableView.beginUpdates()
//                    self.category?.cards.insert(card, at: destinationIndexPath.row)
//                    self.tableView.insertRows(at: [destinationIndexPath], with: .automatic)
//                    self.tableView.endUpdates()
                    self.updateNetwork(localContext: coordinator.session.localDragSession?.localContext,newCategoryId: self.category!.id)
                    break
                case (nil, nil):
                    // Insert data from a table to another table
//                    self.removeSourceTableData(localContext: coordinator.session.localDragSession?.localContext)
//                    self.tableView.beginUpdates()
//                    self.category?.cards.append(card)
//                    self.tableView.insertRows(at: [IndexPath(row: self.category!.cards.count - 1 , section: 0)], with: .automatic)
//                    self.tableView.endUpdates()
                    self.updateNetwork(localContext: coordinator.session.localDragSession?.localContext,newCategoryId: self.category!.id)
                    break

                default: break

                }
            }
        
    }

    func updateNetwork(localContext:Any? , newCategoryId: String){
        if let (dataSource, sourceIndexPath, _) = localContext as? (Category, IndexPath, UITableView) ,let projectId = self.parentVC?.project?.id {

            self.parentVC?.postNetworkMoveCard(projectId: projectId, oldCard: dataSource.cards[sourceIndexPath.row], newCategoryId: newCategoryId)
        }
        
    }
    
    func removeSourceTableData(localContext: Any?) {
        if let (dataSource, sourceIndexPath, tableView) = localContext as? (Category, IndexPath, UITableView) {
            tableView.beginUpdates()
            dataSource.cards.remove(at: sourceIndexPath.row)
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.endUpdates()
            
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
}
