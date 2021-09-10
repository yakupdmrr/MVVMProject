//
//  PostModelService.swift
//  MVVMProject
//
//  Created by Yakup Demir on 12.07.2021.
//

import Foundation
import Alamofire
class PostModelService : NSObject {
    
    static let instance = PostModelService()
    
    private var postModel: AlamofireManager<PostModel> = AlamofireManager<PostModel>()
    
    func getPostModelData(completionHandler:@escaping ([PostModel]) -> Void) {
        
        postModel.getAllData(servicePath: Constants.url) { models in
            completionHandler(models)
        } onFail: { err in
            print(err?.debugDescription ?? "nil error")
        }
        
    }
    func postModelData(postModelParameters:PostModel,completionHandler: @escaping (PostModel) -> Void){
        
        postModel.postData(servicePath: Constants.url, parameters: postModelParameters.toDictionary()) { model in
            completionHandler(model)
        } onFail: { err in
            print(err?.debugDescription ?? "PostModel post Request Error")
        }
    }

}
