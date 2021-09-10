//
//  PostModel.swift
//  MVVMProject
//
//  Created by Yakup Demir on 12.07.2021.
//

import Foundation

struct PostModel: Codable {
    var userId:Int?
    var id:Int?
    var title:String?
    var body:String?
    
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        
        if userId != nil {
            dictionary["userId"] = userId
        }
        if title != nil {
            dictionary["title"] = title
        }
        if body != nil {
            dictionary["body"] = body
        }
        if id != nil {
            dictionary["id"] = id
        }
        
        return dictionary
    }
    
    enum CodingKeys: String, CodingKey {
        case userId
        case title = "title"
        case body = "body"
        case id = "id"
    }
}
