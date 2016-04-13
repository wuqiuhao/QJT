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

typealias SuccessedClosure = ([String:Any?])-> Void
typealias FiledClosure = (String?)-> Void

class NetWorkManager {
    
    /**
     网络数据请求通用接口
     
     - parameter method:       请求方法名
     - parameter params:       请求参数
     - parameter modelType:    返回Model类型
     - parameter listType:     返回List类型
     - parameter completed:    成功返回闭包
     - parameter errorClosure: 失败返回错误信息闭包
     */
    class func httpRequest<T: Mappable>(method: String, params:[String:AnyObject], modelType: T? = nil,listType: T? = nil,completed: SuccessedClosure?, errorClosure: FiledClosure) {
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
        
        Alamofire.request(Method.POST, serviceURL, parameters: params, encoding: ParameterEncoding.URL).responseObject { (response: Response<ReturnResult<T,T>, NSError>) in
            if let resp = response.response {
                switch resp.statusCode {
                case 200:
                    if let result = response.result.value {
                        var responseData = [String:Any?]()
                        let isFailed = result.isFailed
                        let errorMsg = result.errorMsg
                        if let flag = isFailed where flag {
                            errorClosure(errorMsg!)
                        } else {
                            if let model = result.model {
                                responseData.updateValue(model, forKey: "model")
                            }
                            if let list = result.list {
                                responseData.updateValue(list, forKey: "list")
                            }
                            completed!(responseData)
                        }
                    } else {
                        errorClosure("服务器异常")
                    }
                case 404:
                    errorClosure("请求不存在")
                case 500:
                    errorClosure("服务器异常")
                default:
                    errorClosure("网络异常，稍后再试")
                }
            } else {
                errorClosure("网络异常，稍后再试")
            }
        }
    }
}
