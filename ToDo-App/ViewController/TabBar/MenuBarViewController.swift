//
//  MenuBarViewController.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/25/21.
//

import UIKit

class MenuBarViewController: UITabBarController {
    let socket = SocketNotificationManager()
    let projectVC: ProjectController
    let notificationVC: NotificationController
    let settingsVC: SettingController
    
    init(projectVC: ProjectController, notificationVC: NotificationController, settingsVC: SettingController) {
        self.projectVC = projectVC
        self.notificationVC = notificationVC
        self.settingsVC = settingsVC
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        setStyle()
        
        projectVC.tabBarItem = UITabBarItem.init(
            title: "Projects",
            image: UIImage(systemName: "doc.text"),
            selectedImage: UIImage(systemName: "doc.text.fill"))
        
        notificationVC.tabBarItem = UITabBarItem.init(
            title: "Notifications",
            image: UIImage(systemName: "list.dash"),
            selectedImage: UIImage(systemName: "list.dash"))
        
        settingsVC.tabBarItem = UITabBarItem.init(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [projectVC, notificationVC, settingsVC]
        setupDelegates()
    }
    
    func setStyle() {
        tabBar.barTintColor = UIColor.FlatColor.Blue.BlueWhale
        tabBar.tintColor = UIColor.FlatColor.Orange.NeonCarrot
        tabBar.unselectedItemTintColor = .white
        tabBar.isTranslucent = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.stop()
    }
    
    
    func setupDelegates() {
        socket.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MenuBarViewController : SocketNotificationManagerDelegate {
    func didReceive(newNotification: NotificationResponse) {
        let info : [String: String] = ["id": newNotification.id, "date": newNotification.date, "description": newNotification.messageDescription,"projectName": newNotification.project.title]
        NotificationCenter.default.post(name: .didAddNotification, object: info)
        self.tabBar.addBadge(index: 1)
    }
    
    func didConnect() {
        print("Connect")
    }
}
