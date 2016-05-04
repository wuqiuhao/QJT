//
//  SPersonalSignNoteViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalSignNoteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var signNoteArrData = [StudentAttendanceInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - private Method
extension SPersonalSignNoteViewController {
    
    func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "签到记录"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    //状态字符串拼接
    func getStatusStr(queke: Int, chidao: Int, zaotui: Int, qingjia: Int) -> String {
        
        let statusStr = NSMutableString()
        if queke == 1 {
            statusStr.appendString("缺课,")
        }
        if chidao == 1 {
            statusStr.appendString("迟到,")
        }
        if zaotui == 1 {
            statusStr.appendString("早退,")
        }
        if qingjia == 1 {
            statusStr.appendString("请假,")
        }
        if queke == 0 && chidao == 0 && zaotui == 0 && qingjia == 0 {
            statusStr.appendString("出勤.")
        }
        
        return statusStr.substringToIndex(statusStr.length - 1) as String
    }
    
}

extension SPersonalSignNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        
        NetWorkManager.httpRequest(Methods.attendance_studentGetLostAttendanceInfos, params: ["studentID":UserConfig.studentSetting()!.userID], modelType: StudentAttendanceInfo(), listType: StudentAttendanceInfo(), completed: { (responseData) in
            
            self.tableView.mj_header.endRefreshing()
            self.signNoteArrData = responseData["list"] as! [StudentAttendanceInfo]
            self.tableView.reloadData()
            
        }) { [weak self] (errorMsg) in
            self?.errorNotice(errorMsg!)
            self?.tableView.mj_header.endRefreshing()
            
        }
        
    }
}

// MARK: - UITableViewDelegate
extension SPersonalSignNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForSignNote = "SPersonalSignNoteCell"
extension SPersonalSignNoteViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.signNoteArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForSignNote, forIndexPath: indexPath) as! SPersonalSignNoteCell
        let attendance = self.signNoteArrData[indexPath.row]
        cell.timeLabel.text = attendance.attendanceTime.stringForDateFormat("yyyy.MM.dd")
        cell.courseNameLabel.text = attendance.courseName
        print("\(attendance.courseName)")
        cell.teacherNameLabel.text = attendance.teacherName
        cell.statusLabel.text = getStatusStr(attendance.queke, chidao: attendance.chidao, zaotui: attendance.zaotui, qingjia: attendance.qingjia)
        
        return cell
    }
}


