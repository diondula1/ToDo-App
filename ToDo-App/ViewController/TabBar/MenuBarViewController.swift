//
//  MenuBarViewController.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/25/21.
//

import UIKit

class MenuBarViewController: UITabBarController {
    
    let socket = SocketNotificationManager()
    
    override func viewDidLoad() {
        
        self.tabBar.barTintColor = UIColor.FlatColor.Blue.BlueWhale
        self.tabBar.tintColor = UIColor.FlatColor.Orange.NeonCarrot
        self.tabBar.unselectedItemTintColor = .white
        
        self.tabBar.isTranslucent = false
        
        let projectVC = ProjectController()
        projectVC.tabBarItem = UITabBarItem.init(title: "Projects", image: UIImage(systemName: "doc.text"), selectedImage: UIImage(systemName: "doc.text.fill"))
        
        
        let notificationVC = NotificationController()
        notificationVC.tabBarItem = UITabBarItem.init(title: "Notifications", image: UIImage(systemName: "list.dash"), selectedImage: UIImage(systemName: "list.dash"))
        
        let settingsVC = SettingController()
        settingsVC.tabBarItem = UITabBarItem.init(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        let vc1 = UINavigationController(rootViewController: projectVC)
        let vc2 = UINavigationController(rootViewController: notificationVC)
        let vc3 = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [vc1, vc2, vc3]
        setupDelegates()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.stop()
    }
    
    
    func setupDelegates() {
        
        socket.delegate = self
    }
}


extension MenuBarViewController : SocketNotificationManagerDelegate {
    func didReceive(newNotification: NotificationResponse) {
        let info : [String: String] = ["id": newNotification.id,"date": newNotification.date,"description": newNotification.messageDescription,"projectName": newNotification.project.title]
        NotificationCenter.default.post(name: .didAddNotification, object: info)
        self.tabBar.addBadge(index: 1)
    }
    
    func didConnect() {
        print("Connect")
    }
    
}
