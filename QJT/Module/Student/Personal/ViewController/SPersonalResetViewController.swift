//
//  SPersonalResetViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/1.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalResetViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var firstTfd = UITextField()
    var secondTfd = UITextField()
    var thirdTfd = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

// MARK: - private Method
extension SPersonalResetViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "修改密码"
        tableView.tableFooterView = UIView()
        
        let rightItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: #selector(SPersonalResetViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func rightItemClicked() {
        
        if firstTfd.text!.characters.count == 0 {
            self.errorNotice("请填写原密码")
            return
        }
        if secondTfd.text!.characters.count == 0 {
            self.errorNotice("请填写新密码")
            return
        }
        
        if thirdTfd.text!.characters.count == 0 {
            self.errorNotice("请确认新密码")
            return
        }
        
        if  secondTfd.text! != thirdTfd.text! {
            self.errorNotice("两次填写的新密码不一致")
            return
        }
        
        var params = [String:AnyObject]()
        params.updateValue(UserConfig.studentSetting()!.userID, forKey: "studentID")
        params.updateValue(firstTfd.text!, forKey: "oldPassword")
        params.updateValue(thirdTfd.text!, forKey: "newPassword")
        
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.login_studentChangePassword, params: params, modelType: EmptyModel(), listType: nil, completed: { (responseData) in
                self.clearAllNotice()
                self.successNotice("修改成功")
                self.navigationController?.popViewControllerAnimated(true)
            }) { [weak self] (errorMsg) in
                self?.errorNotice(errorMsg!)
        }
    }
}

// MARK: - UITableViewDelegate
extension SPersonalResetViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDataSource
private let cellIdeiferForResetCell = "SPersonalResetCell"
extension SPersonalResetViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeiferForResetCell, forIndexPath: indexPath) as! SPersonalResetCell
        if indexPath.row == 0 {
            cell.resetTfd.placeholder = "请填写原密码"
            firstTfd = cell.resetTfd
        } else if indexPath.row == 1 {
            cell.resetTfd.placeholder = "请填写新密码"
            secondTfd = cell.resetTfd
        } else if indexPath.row == 2 {
            cell.resetTfd.placeholder = "请确认新密码"
            thirdTfd = cell.resetTfd
        }
        return cell
    }
}