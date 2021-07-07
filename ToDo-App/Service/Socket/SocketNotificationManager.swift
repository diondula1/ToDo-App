//
//  SocketManager.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/17/21.
//

import UIKit
import SocketIO

class SocketNotificationManager {

    // MARK: - Delegate
    
    weak var delegate: SocketNotificationManagerDelegate?
    
    // MARK: - Properties
    let manager = SocketManager(socketURL: URL(string: "http://127.0.0.1:3002")!, config: [.log(false), .compress])
    var socket: SocketIOClient? = nil

    // MARK: - Life Cycle
    init() {
        setupSocket()
        setupSocketEvents()
        socket?.connect()
    }

    func stop() {
        socket?.removeAllHandlers()
    }

    // MARK: - Socket Setups
    func setupSocket() {
        self.socket = manager.defaultSocket
    }

    
    func setupSocketEvents() {

        socket?.on(clientEvent: .connect) {data, ack in
            print("Connect")
        
            self.socket?.emit("notification", UserDefaultsData.id)
            self.delegate?.didConnect()
        }
        
        socket?.on("new notification") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: NotificationResponse = try? SocketParser.convert(data: dataInfo) {
                
                self.delegate?.didReceive(newNotification: response)
            }
        }
    }
}


protocol SocketNotificationManagerDelegate: class {
    func didConnect()
    func didReceive(newNotification: NotificationResponse)
}
