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
        accountTfd.text = "2012812044"
        passwordTfd.text = "2012812044"
        configUI()
        setupLoginBtn()
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
        
        loginViewLeadingLayoutConstraint.constant = 180
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            self.view.layoutIfNeeded()
            self.accountTfd.resignFirstResponder()
            self.passwordTfd.resignFirstResponder()
            
        })
        
        if accountTfd.text == "" && accountTfd.text?.characters.count == 0{
            self.errorNotice("账号为空")
            return
        }
        
        if passwordTfd.text == "" && passwordTfd.text?.characters.count == 0{
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
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.login_studentLogin, params: params, modelType: StudentSetting(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            let result = responseData["model"] as! StudentSetting
            print(result)
            let mainWindow = UIApplication.sharedApplication().keyWindow
            mainWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! as UIViewController
            }) { [weak self] (errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
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
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loginBtnClicked()
        return true
    }
}


//        NetWorkManager.httpRequest(Methods.test, params: ["userName":"","passWord":""], modelType: Student(), completed: { (responseData) in
//            print("\(responseData)")
//        }) { (errorMsg) in
//            debugPrint(errorMsg!)
//        }