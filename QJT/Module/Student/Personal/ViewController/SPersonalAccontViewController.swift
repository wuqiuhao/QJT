//
//  SPersonalAccontViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalAccontViewController: UIViewController {

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
extension SPersonalAccontViewController {
    
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
extension SPersonalAccontViewController {
    func logoutBtnClicked() {
        let alertVC = UIAlertController(title: "注意", message: "确认要注销吗?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            let mainWindow = UIApplication.sharedApplication().keyWindow
            if UserConfig.removeAllFileInSandbox() {
                mainWindow?.rootViewController = UIStoryboard(name: "RegLogin", bundle: nil).instantiateInitialViewController()
            } else {
                self.errorNotice("注销失败")
            }
//            NetWorkManager.httpRequest(Methods.login_studentLogout, params: ["studentID":UserConfig.studentSetting()!.userID], modelType: EmptyModel(), listType: nil, completed: { (responseData) in
//                let mainWindow = UIApplication.sharedApplication().keyWindow
//                if UserConfig.removeAllFileInSandbox() {
//                    mainWindow?.rootViewController = UIStoryboard(name: "RegLogin", bundle: nil).instantiateInitialViewController()
//                } else {
//                    self.errorNotice("注销失败")
//                }
//                }, errorClosure: {(errorMsg) in
//            })
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in
            
        }
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension SPersonalAccontViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SPersonalResetViewController", sender: nil)
    }
}

// MARK: - UITableViewDataSource
extension SPersonalAccontViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SPersonalLogoutCell", forIndexPath: indexPath) as! SPersonalLogoutCell
        cell.titleLbl.text = "修改密码"
        return cell
    }
}

class SPersonalLogoutCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
}