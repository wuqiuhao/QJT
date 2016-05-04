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
    
    var leaveCourseArr = [LeaveDetail]()
    var leave: Leave!
    var courseStr = ""
    var leaveID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getNetwork()
    }
}

// MARK: - private Method
extension SPersonalLNDetailViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假单"
        tableView.estimatedRowHeight = 100
    }
    
    func getNetwork() {
        NetWorkManager.httpRequest(Methods.leave_getLeaveDetailByLeaveID, params: ["leaveID":leaveID], modelType: Leave(), listType: LeaveDetail(), completed: { (responseData) in
            self.leaveCourseArr = responseData["list"] as! [LeaveDetail]
            self.leave = responseData["model"] as! Leave
            var i = 0
            for data in self.leaveCourseArr {
                if i != self.leaveCourseArr.count - 1 {
                    self.courseStr = self.courseStr + data.courseName + " " + data.address + "\n"
                } else {
                    self.courseStr = self.courseStr + data.courseName + " " + data.address
                }
                i += 1
            }
            self.tableView.reloadData()
            }) { [weak self](errorMsg) in
                self?.errorNotice(errorMsg!)
        }
    }
}

// MARK: - UITableViewDelegate
extension SPersonalLNDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
        if let _ = leave {
            return 2
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            if leave.leaveState == .Failed {
                return 3
            } else {
                return 2
            }

        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForDetailCell, forIndexPath: indexPath) as! SPersonalLNDetailCell
        cell.phoneImg.hidden = true
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.titleLbl.text = "请假时间:"
                cell.detailLbl.text = leave.fromTime.stringForDateFormat("yyyy.MM.dd") + " -- " + leave.toTime.stringForDateFormat("yyyy.MM.dd")
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "请假课程:"
                cell.detailLbl.text = courseStr
            } else if indexPath.row == 2 {
                cell.titleLbl.text = "请假理由:"
                cell.detailLbl.text = leave.reason
            }
            return cell
        case 1:
            if indexPath.row == 0 {
                cell.titleLbl.text = "审核教师:"
                cell.detailLbl.text = leave.teacherName
                cell.fatherVC = self
                cell.phoneImg.hidden = false
                
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "审核状态:"
                cell.detailLbl.text = leave.leaveState.toDescription()
            } else if indexPath.row == 2 {
                cell.titleLbl.text = "拒绝原因:"
                cell.detailLbl.text = leave.refuseReason
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}