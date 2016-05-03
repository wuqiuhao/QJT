//
//  CLTPersonalAttendanceNoteViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTPersonalAttendanceNoteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var attendanceArrData = [Attendance]()
    var attendanceID: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CLTPersonalAttendanceNoteViewController.refreshNote), name: "refreshNote", object: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cLTPersonalANDetailViewController" {
            let detailView = segue.destinationViewController as! CLTPersonalANDetailViewController
            detailView.attendanceID = attendanceID
        }
        
        
    }

}

// MARK: - private Method
extension CLTPersonalAttendanceNoteViewController {
    func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "考勤记录"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
//    func getNetwork() {
//        self.pleaseWait()
//        NetWorkManager.httpRequest(Methods.attendance_getAttendanceInfosByTeacherID, params: ["teacherID":UserConfig.teacherSetting()!.userID], modelType: Attendance(), listType: Attendance(), completed: { (responseData) in
//            
//            self.clearAllNotice()
//            self.attendanceArrData = responseData["list"] as! [Attendance]
//            self.tableView.reloadData()
//            
//        }) { (errorMsg) in
//            self.clearAllNotice()
//            
//        }
//    }
    
    func refreshNote() {
        tableView.headerRefresh = true
    }
    
}

extension CLTPersonalAttendanceNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceInfosByTeacherID, params: ["teacherID":UserConfig.teacherSetting()!.userID], modelType: Attendance(), listType: Attendance(), completed: { (responseData) in
            
            self.tableView.mj_header.endRefreshing()
            self.attendanceArrData = responseData["list"] as! [Attendance]
            self.tableView.reloadData()
            
        }) { [weak self] (errorMsg) in
            self?.tableView.mj_header.endRefreshing()
            
        }
    }
}

// MARK: - UITableViewDelegate
extension CLTPersonalAttendanceNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        attendanceID = attendanceArrData[indexPath.row].attendanceID
        self.performSegueWithIdentifier("cLTPersonalANDetailViewController", sender: nil)
        
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForAttendanceNote = "CLTPersonalAttendanceNoteCell"
extension CLTPersonalAttendanceNoteViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attendanceArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForAttendanceNote, forIndexPath: indexPath) as! CLTPersonalAttendanceNoteCell
        let attendance = self.attendanceArrData[indexPath.row]
        
        cell.timeLabel.text = attendance.updateTime.stringForDateFormat("yyyy.MM.dd")
        cell.courseNameLabel.text = attendance.courseName
        cell.classNameLabel.text = attendance.className
        cell.quekeLabel.text = "\(attendance.quekeCount)"
        cell.chidaoLabel.text = "\(attendance.chidaoCount)"
        cell.zaotuiLabel.text = "\(attendance.zaotuiCount)"
        cell.qingjiaLabel.text = "\(attendance.qingjiaCount)"
        
        return cell
    }
}

