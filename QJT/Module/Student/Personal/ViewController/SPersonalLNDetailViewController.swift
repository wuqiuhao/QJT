//
//  SPersonalLNDetailViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalLNDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

// MARK: - private Method
extension SPersonalLNDetailViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假单"
    }
    
    func getNetwork() {
        
    }
}

// MARK: - UITableViewDelegate
extension SPersonalLNDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "请假明细"
        } else {
            return "审核明细"
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForDetailCell = "SPersonalLNDetailCell"
extension SPersonalLNDetailViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForDetailCell, forIndexPath: indexPath) as! SPersonalLNDetailCell
        cell.phoneImg.hidden = true
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.titleLbl.text = "请假时间:"
                cell.detailLbl.text = "2016.1.4 - 2016.1.6"
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "请假课程:"
                cell.detailLbl.text = "C语言设计 - B301 - 寿周翔"
            } else if indexPath.row == 2 {
                cell.titleLbl.text = "请假理由:"
                cell.detailLbl.text = "肚子痛"
            }
            return cell
        case 1:
            if indexPath.row == 0 {
                cell.titleLbl.text = "审核教师:"
                cell.detailLbl.text = "李文娟"
                cell.fatherVC = self
                cell.phoneImg.hidden = false
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "审核状态:"
                cell.detailLbl.text = "审核中"
            } else if indexPath.row == 2 {
                cell.titleLbl.text = "拒绝原因:"
                cell.detailLbl.text = "不能请假"
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}