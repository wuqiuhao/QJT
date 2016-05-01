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
        } else if indexPath.row == 1 {
            cell.resetTfd.placeholder = "请填写新密码"
        } else if indexPath.row == 2 {
            cell.resetTfd.placeholder = "请确认新密码"
        }
        return cell
    }
}