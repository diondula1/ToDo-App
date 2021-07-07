//
//  StringUrl+Extension.swift
//  PolymathLabs TechnicalChallenge
//
//  Created by Dion Dula on 2/27/21.
//

import Foundation
extension String{
    
    func getBaseServerURL() -> String {
        "http://127.0.0.1:3000/api"
    }
    //MARK: Auth
    func getLoginServerURL() -> String {
        getBaseServerURL() + "/auth/login"
    }
    
    func getRegisterServerURL() -> String {
        getBaseServerURL() + "/auth/register"
    }
    
    //MARK: Card
    func getCardsURL(projectId : String) -> String{
        getBaseServerURL() + "/project/\(projectId)/category/1/card/list"
    }
    
    func postCardsURL(projectId : String,categoryId:String) -> String{
        getBaseServerURL() + "/project/\(projectId)/category/\(categoryId)/card/add"
    }
    
    func updateCardURL(projectId : String,categoryId:String,newCategoryId: String) -> String{
        getBaseServerURL() + "/project/\(projectId)/category/\(categoryId)/card/move/\(newCategoryId)"
    }
    
    func deleteCardsURL(projectId: String,categoryId: String,cardId: String) -> String{
        getBaseServerURL() + "/project/\(projectId)/category/\(categoryId)/card/delete/\(cardId)"
    }
    
    //MARK: Category
    func postCategoryURL(projectId : String) -> String{
        getBaseServerURL() + "/project/\(projectId)/category/add"
    }
    
    //MARK: Profile
    func getProfileServerURL() -> String {
        getBaseServerURL() + "/profile/view"
    }
    
    //MARK: Project
    func getProjectServerURL() -> String {
        getBaseServerURL() + "/project/list"
    }
    
    func postProjectServerURL() -> String{
        getBaseServerURL() + "/project/add"
    }

   //MARK: Notification

    func getNotificationServerURL(projectId : String) -> String {
        getBaseServerURL() + "/project/\(projectId)/log/listall"
    }
}


