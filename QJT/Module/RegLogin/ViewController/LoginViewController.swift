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
    @IBOutlet var accountImg: UIImageView!
    @IBOutlet var passwordImg: UIImageView!
    @IBOutlet weak var studentBtn: DLRadioButton!
    @IBOutlet weak var teacherBtn: DLRadioButton!
    
    var userType: String = "学生"
    
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
        navigationItem.title = "登录"
        passwordTfd.becomeFirstResponder()
        accountTfd.delegate = self
        passwordTfd.delegate = self
        createRadioButton(studentBtn, title: "学生", color: UIColor.qjtNavgationBarTitleColor())
        createRadioButton(teacherBtn, title: "教师", color: UIColor.qjtNavgationBarTitleColor())
        studentBtn.selected = true
        studentBtn.otherButtons = [teacherBtn];
        
        if let _ = UserConfig.lastUsername() {
            accountTfd.text = UserConfig.lastUsername()
        }
        
    }
    
    func setupLoginBtn() {
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.masksToBounds = true
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.accountTfd.resignFirstResponder()
        self.passwordTfd.resignFirstResponder()
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
    
    func createRadioButton(button: DLRadioButton, title : String, color : UIColor) {
        button.titleLabel!.font = UIFont.systemFontOfSize(13)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(color, forState: UIControlState.Normal)
        button.iconColor = color
        button.indicatorColor = color
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        button.addTarget(self, action: #selector(LoginViewController.idSelected), forControlEvents: UIControlEvents.TouchUpInside);
    }
    
}

// MARK: - IB Action
extension LoginViewController {
    
    func loginBtnClicked() {
        
        if accountTfd.text == "" && accountTfd.text?.characters.count == 0{
            self.errorNotice("账号为空")
            return
        }
        
        if passwordTfd.text == "" && passwordTfd.text?.characters.count == 0{
            self.errorNotice("密码为空")
            return
        }
        
        if userType == "" && userType.characters.count == 0 {
            self.errorNotice("身份未选择")
            return
        }
        
        var params = [String:AnyObject]()
        var method = ""
        if userType == "学生" {
            params.updateValue(accountTfd.text!, forKey: "studentID")
            params.updateValue(passwordTfd.text!, forKey: "password")
            
            method = Methods.login_studentLogin
            if let _ = JPUSHService.registrationID() {
                params.updateValue(JPUSHService.registrationID(), forKey: "registerID")
            } else {
                params.updateValue("", forKey: "registerID")
            }
            params.updateValue(getUUID(), forKey: "deviceID")
            self.pleaseWait()
            NetWorkManager.httpRequest(method, params: params, modelType: StudentSetting(), listType: nil, completed: { (responseData) in
                self.clearAllNotice()
                let studentSetting = responseData["model"] as! StudentSetting
                UserConfig.saveStudentSetting(studentSetting)
                UserConfig.saveLastUsername(studentSetting.userID)
                let mainWindow = UIApplication.sharedApplication().keyWindow
                let mainTabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! as! MainTabBarController
                mainTabBarVC.userType = studentSetting.userType
                mainWindow?.rootViewController = mainTabBarVC
            }) { [weak self] (errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
            }
        } else {
            params.updateValue(accountTfd.text!, forKey: "teacherID")
            params.updateValue(passwordTfd.text!, forKey: "password")
            params.updateValue(2, forKey: "userType")
            if let _ = JPUSHService.registrationID() {
                params.updateValue(JPUSHService.registrationID(), forKey: "registerID")
            } else {
                params.updateValue("", forKey: "registerID")
            }
            method = Methods.login_teacherLogin
            self.pleaseWait()
            NetWorkManager.httpRequest(method, params: params, modelType: TeacherSetting(), listType: nil, completed: { (responseData) in
                self.clearAllNotice()
                let teacherSetting = responseData["model"] as! TeacherSetting
                UserConfig.saveTeacherSetting(teacherSetting)
                UserConfig.saveLastUsername(teacherSetting.userID)
                let mainWindow = UIApplication.sharedApplication().keyWindow
                let mainTabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! as! MainTabBarController
                mainTabBarVC.userType = teacherSetting.userType
                mainWindow?.rootViewController = mainTabBarVC
            }) { [weak self] (errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
            }
        }
    }
    
    func idSelected(button: DLRadioButton) {
        if button.titleLabel!.text == "学生" {
            userType = "学生"
        } else {
            userType = "教师"
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loginBtnClicked()
        return true
    }
}
