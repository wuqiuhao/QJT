//
//  LoginViewController.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/29.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var accountTfd: UITextField!
    @IBOutlet weak var passwordTfd: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var loginViewLeadingLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLoginBtn()
        //print(JPUSHService.registrationID())

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
        
}

// MARK: - private Method
extension LoginViewController {
    
    func configUI() {
        
        accountTfd.delegate = self
        passwordTfd.delegate = self
        
    }
    
    func setupLoginBtn() {
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        loginViewLeadingLayoutConstraint.constant = 180
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            self.view.layoutIfNeeded()
            self.accountTfd.resignFirstResponder()
            self.passwordTfd.resignFirstResponder()

        })
    }
    
    //获取设备唯一ID
    func getUUID() -> String {
        let wrapper = KeychainItemWrapper(identifier: "QJT", accessGroup: "YKSTK56XPJ.com.design.qianjiangtong")
        var uuid = wrapper.objectForKey(kSecValueData)
        if uuid == nil || uuid.isEqual("") {
            wrapper.setObject("QJT", forKey: kSecAttrAccount)
            wrapper.setObject(createUUID(), forKey: kSecValueData)
            uuid = wrapper.objectForKey(kSecValueData)
        }
        print(uuid)
        return uuid as! String
    }
    
    //创建设备唯一ID
    func createUUID() -> NSString {
        let uuid_ref = CFUUIDCreate(nil)
        let uuid_string_ref = CFUUIDCreateString(nil, uuid_ref)
        let uuid = NSString(string: uuid_string_ref)
        return uuid
    }
    
}

// MARK: - IB Action
extension LoginViewController {
    
    func loginBtnClicked() {
        
        guard let _ = accountTfd.text else {
            self.errorNotice("用户名为空")
            return
        }
        
        guard let _ = passwordTfd.text else {
            self.errorNotice("密码为空")
            return
        }
        
        var params = [String:AnyObject]()
        params.updateValue(accountTfd.text!, forKey: "studentID")
        params.updateValue(passwordTfd.text!, forKey: "password")
        if let _ = JPUSHService.registrationID() {
            params.updateValue(JPUSHService.registrationID(), forKey: "registerID")
        } else {
            params.updateValue("", forKey: "registerID")
        }
        
        params.updateValue(getUUID(), forKey: "deviceID")
        NetWorkManager.httpRequest(Methods.login_studentLogin, params: params, modelType: StudentSetting(), listType: nil, completed: { (responseData) in
            let result = responseData["model"] as! StudentSetting
            print(result)
            }) { (errorMsg) in
                print(errorMsg)
        }
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

        loginViewLeadingLayoutConstraint.constant = 50
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }

        return true
    }
    
}


//        NetWorkManager.httpRequest(Methods.test, params: ["userName":"","passWord":""], modelType: Student(), completed: { (responseData) in
//            print("\(responseData)")
//        }) { (errorMsg) in
//            debugPrint(errorMsg!)
//        }