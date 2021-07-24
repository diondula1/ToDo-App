//
//  SocketManager.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/17/21.
//

import UIKit
import SocketIO

class SocketTodoManager {

    // MARK: - Delegate
    
    weak var delegate: SocketCardManagerDelegate?
    var projectId : String?
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
            guard let projectId = self.projectId else {
                return
            }
            self.socket?.emit("room", projectId)
            self.delegate?.didConnect()
        }

        socket?.on("new card") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: Card = try? SocketParser.convert(data: dataInfo) {
                
                self.delegate?.didReceive(newCard: response)
            }
        }
        
        socket?.on("remove card") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: Card = try? SocketParser.convert(data: dataInfo) {
                
                self.delegate?.didReceiveRemove(removeCard: response)
            }
        }


        socket?.on("new category") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: Category = try? SocketParser.convert(data: dataInfo) {
                
                self.delegate?.didReceive(newCategory: response)
            }
        }
        
        socket?.on("move card") { (data, ack) in
            guard let dataInfo = data.first else { return }
            if let response: ResponseMoveCard = try? SocketParser.convert(data: dataInfo) {
                
                self.delegate?.didReceive(moveCard: response)
            }
        }
    }
}

struct SocketPosition: Codable {
    var x: Double
    var y: Double
}

protocol SocketCardManagerDelegate: AnyObject {
    func didConnect()
    func didReceive(newCard: Card)
    func didReceive(newCategory: Category)
    func didReceive(moveCard: ResponseMoveCard)
    func didReceiveRemove(removeCard: Card)
}
