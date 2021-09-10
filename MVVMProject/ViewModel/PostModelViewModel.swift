//
//  PostModelViewModel.swift
//  MVVMProject
//
//  Created by Yakup Demir on 12.07.2021.
//

import Foundation

struct PostModelListViewModel {
    var postModelList: [PostModel]
    
    func numberOfSection() -> Int {
        return self.postModelList.count
    }
    func postModelAtIndex(_ index:Int) -> PostModelViewModel {
        let post = postModelList[index]
        return PostModelViewModel(postModel: post)
    }
        
}

struct PostModelViewModel {
    let postModel:PostModel
    var id:Int{
        return self.postModel.id ?? 0
    }
    var userId:Int{
        return self.postModel.userId ?? 0
    }
    var title:String{
        return self.postModel.title ?? "nil title"
    }
    var body :String {
        return self.postModel.body ?? "nil body"
    }
}
