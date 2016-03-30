//
//  NetWorkManager.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

typealias SuccessedClosure = ([String:AnyObject?])-> Void
typealias FiledClosure = (String?)-> Void

class NetWorkManager {
    
    class func httpRequest(method: String, params:[String:AnyObject], modelType: AnyClass,completed: SuccessedClosure?, errorClosure: FiledClosure) {
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
        
//        Alamofire.request(Method.POST, serviceURL, parameters: params, encoding: ParameterEncoding.URL).responseObject { (response: Response<Student, NSError>) in
//            if let failableUser = response.result.value {
//                if let user = failableUser.object {
//                    // handle User object
//                }
//                else if let apiError = failableUser.apiError {
//                    // handle API error
//                }
//                else {
//                    // ...
//                }
//            }
//            else {
//                // ...
//            }
//        }
        Alamofire.request(Method.POST, serviceURL, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (responseData) in
            let response = responseData.response
            if response == nil {
                debugPrint("请求失败")
            }
            switch response!.statusCode {
            case 200:
                // http请求成功
                let result = responseData.result.value
                let isFailed = result!["failed"] as! Bool
                let errorMsg = result!["errorMsg"] as! String
                let modelJson = result!["modelJson"] as! String
                let listJson = result!["listJson"] as! String
                debugPrint("isFailed:\(isFailed)")
                debugPrint("errorMsg:\(errorMsg)")
                debugPrint("modelJson:\(modelJson)")
                debugPrint("listJson:\(listJson)")
                
                if isFailed {
                    errorClosure(errorMsg)
                } else {
                    // 成功获取数据
                    let model = Mapper<Student>().map(modelJson)
                    debugPrint(model)
                }
            case 404:
                errorClosure("请求不存在")
            case 500:
                errorClosure("服务器异常")
            default:
                errorClosure("网络异常，稍后再试")
            }
        }
    }
}
