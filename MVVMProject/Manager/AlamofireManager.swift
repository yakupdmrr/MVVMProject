//
//  AlamofireManager.swift
//  MVVMProject
//
//  Created by Yakup Demir on 12.07.2021.
//

import Foundation
import Alamofire

protocol RestApiProtocol {
    
    associatedtype T
    
    func getAllData(servicePath:URLConvertible,onSuccess:@escaping ([T]) -> Void, onFail:@escaping (String?) -> Void )
    func postData(servicePath:URLConvertible, parameters:Parameters?, onSuccess:@escaping (T) -> Void, onFail:@escaping (String?) -> Void)
    
}

struct AlamofireManager<T:Codable> :RestApiProtocol {
    
    func postData(servicePath: URLConvertible, parameters: Parameters?=nil, onSuccess: @escaping (T) -> Void, onFail: @escaping (String?) -> Void) {
        
        let encoding:ParameterEncoding = JSONEncoding.default
        let headers:HTTPHeaders = ["Content-type":"application/json; charset=UTF-8"]
        
        AF.request(servicePath,method: .post,parameters: parameters,encoding: encoding,headers: headers).validate().responseDecodable(of: T.self) { response in
            
            guard let item = response.value else {
                onFail("Error-> \(response.debugDescription)")
                return
            }
            onSuccess(item)
        }
    }
    
    func getAllData(servicePath: URLConvertible, onSuccess: @escaping ([T]) -> Void, onFail: @escaping (String?) -> Void) {
        
        AF.request(servicePath,method: .get).validate().responseDecodable(of: [T].self) { (response) in
            
            guard let items = response.value else {
                onFail("Error-> \(response.debugDescription)")
                return
            }
            onSuccess(items)
        }
        
    }
}

