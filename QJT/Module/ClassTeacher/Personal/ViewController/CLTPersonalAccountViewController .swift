//
//  CLTPersonalAccountViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/1.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTPersonalAccountViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: - private Method
extension CLTPersonalAccountViewController {
    
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "账号安全"
    }
    
    func setupButton() {
        logoutBtn.layer.cornerRadius = 5
        logoutBtn.layer.masksToBounds = true
        logoutBtn.addTarget(self, action: #selector(SPersonalAccontViewController.logoutBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }
}

// MARK: - IB Action
extension CLTPersonalAccountViewController {
    func logoutBtnClicked() {
        let alertVC = UIAlertController(title: "注意", message: "确认要注销吗?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            NetWorkManager.httpRequest(Methods.login_teacherLogout, params: ["teacherID":UserConfig.teacherSetting()!.userID], modelType: EmptyModel(), listType: nil, completed: { (responseData) in
                let mainWindow = UIApplication.sharedApplication().keyWindow
                if UserConfig.removeAllFileInSandbox() {
                    mainWindow?.rootViewController = UIStoryboard(name: "RegLogin", bundle: nil).instantiateInitialViewController()
                }
                }, errorClosure: { (errorMsg) in
                    let mainWindow = UIApplication.sharedApplication().keyWindow
                    if UserConfig.removeAllFileInSandbox() {
                        mainWindow?.rootViewController = UIStoryboard(name: "RegLogin", bundle: nil).instantiateInitialViewController()
                    }
            })
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in
            
        }
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension CLTPersonalAccountViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "SPersonal", bundle: nil).instantiateViewControllerWithIdentifier("SPersonalResetViewController") as! SPersonalResetViewController
        vc.userType = UserType.ClassTeacher
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CLTPersonalAccountViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CLTPersonalLogoutCell", forIndexPath: indexPath) as! CLTPersonalLogoutCell
        cell.titleLbl.text = "修改密码"
        return cell
    }
}

class CLTPersonalLogoutCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
}