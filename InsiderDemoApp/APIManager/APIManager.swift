//
//  APIManager.swift
//  InsiderDemoApp
//
//  Created by Archit Rai Saxena on 25/08/20.
//  Copyright © 2020 Archit. All rights reserved.
//

import UIKit
import Foundation

protocol APISericeRequest {
    // base `URL`.
    var baseURL: URL { get }
    //appended to `baseURL` to form the full `URL`.
    var path: String { get }
    //  HTTP request.
    var request: URLRequest { get }
}

public enum ItunesAPI {
    case search(query:String,media:String,limit:Int)
}
extension ItunesAPI : APISericeRequest {

 
 var baseURL: URL {
     return URL(string: "https://itunes.apple.com")!
 }
 
 var path: String {
     switch self {
     case  .search:
         return "/search"
     }
 }
 
 var request: URLRequest {
     switch self {
        case let .search(query, media, limit):
         return createURLRequestQuery(paramters: ["term":query,"media":media,"limit":limit])
     }
 }
 // Format URL URLRequestQuery
     func createURLRequestQuery(paramters: [String: Any]?) -> URLRequest {
         
         let url = self.baseURL.absoluteString + self.path
         let  query  =  paramters?.map({"\($0.key)=\($0.value)"}).joined(separator: "&")
         var components = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: true)!
         components.query = query
         
         return URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
     }
     
     
 }
class APIManager: NSObject {

   
    static let shared = APIManager()
   
    

    func request(_ target:ItunesAPI, succes successCallback:@escaping (Data)->Void,
                 failure failureCallback: ((Any?,Error?) -> Void)?) {

        let session = URLSession.shared
        let dataTask = session.dataTask(with: target.request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
                if let  failure = failureCallback {
                    failure(nil,error)
                }
            } else {
                if let data = data {
                    successCallback(data)
                }else{
                    if let  failure = failureCallback {
                        failure(nil,error)
                    }
                }
            }
        })
        
        dataTask.resume()

    }

}
