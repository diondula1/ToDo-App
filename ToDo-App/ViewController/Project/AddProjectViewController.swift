//
//  AddProjectViewController.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/17/21.
//

import UIKit
import SimpleNetworkCall

class AddProjectViewController: UIViewController {
    
    typealias DidAddProjectHandler = (Project) -> ()
    var didAddProject : DidAddProjectHandler?
    
    var titleTextField : UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Title"
        return textField
    }()
    
    var addButton : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Project", for: .normal)
        button.backgroundColor = UIColor.FlatColor.Blue.BlueWhale
        button.setTitleColor(UIColor.FlatColor.Orange.NeonCarrot, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        addButton.addTarget(self, action: #selector(addProjectAction), for: .touchUpInside)
        setupView()
    }
    
    func setupView(){
        view.addSubview(titleTextField)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            addButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //MARK: Action
    @objc
    func addProjectAction(){
        guard let title = titleTextField.text , !title.isEmpty else {
            return
        }
        let requestProject = RequestProject(Title: title)
        Network.shared.post(body: requestProject, urlString: "".postProjectServerURL()) { (results:Result<ReturnObject<Project>,Error>) in
            switch(results){
            case .success(let data):
                if data.success {
                    if let data = data.data {
                        self.addingProject(project: data)
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
    
    
    func addingProject(project: Project){
        if  let didAddProject = self.didAddProject {
            didAddProject(project)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
