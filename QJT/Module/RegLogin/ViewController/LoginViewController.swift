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
        
//        let lineLayer = CALayer()
//        print(accountTfd.bounds.height)
//        lineLayer.frame = CGRect(x: 0, y: 30, width: UIScreen.mainScreen().bounds.width, height: 1 / UIScreen.mainScreen().scale)
//        lineLayer.backgroundColor = UIColor.blueColor().CGColor
//        accountTfd.layer.addSublayer(lineLayer)
        
    }
    
    func setupLoginBtn() {
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
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
    func getUUID() {
        
        let wrapper = KeychainItemWrapper(identifier: "QJT", accessGroup: "YKSTK56XPJ.com.design.qianjiangtong")
        var str = wrapper.objectForKey(kSecValueData)
        if str == nil || str.isEqual("") {
            wrapper.setObject("QJT", forKey: kSecAttrAccount)
            wrapper.setObject(createUUID(), forKey: kSecValueData)
            str = wrapper.objectForKey(kSecValueData)
        }
        print(str)
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