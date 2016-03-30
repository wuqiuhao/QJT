//
//  LoginViewController.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkManager.httpRequest(Methods.login_studentLogin, params: ["userName":"2012812044","passWord":"2012812044"], modelType: Student.self,completed: { (responseData) in
                print(responseData)
            }) { (errorMsg) in
                debugPrint(errorMsg!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
