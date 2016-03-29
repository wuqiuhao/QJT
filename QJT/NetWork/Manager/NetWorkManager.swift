//
//  NetWorkManager.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import Alamofire

typealias SuccessedClosure = ([String:AnyObject?])-> Void
typealias FiledClosure = (String?)-> Void

class NetWorkManager {
    
    class func httpRequest(method: String, params:[String:AnyObject], completed: SuccessedClosure?, errorClosure: FiledClosure) {
        var serviceName: String?
        let serviceDic = Methods.getServiceMethod()
        for (key, value) in serviceDic {
            let methods = value as! [String]
            for temp in methods {
                if temp == method {
                    serviceName = key
                }
            }
        }
        let serviceURL = "\(SysConfig.getServerURL())\(serviceName!)/\(method)"
        
        
        Alamofire.request(Method.POST, serviceURL, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }        }
    }
}
