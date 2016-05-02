//
//  ADAttendanceNoteViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class ADAttendanceNoteViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var attendanceArrData = [Attendance]()
    var attendanceID: Int?
    var classID: Int?
    var fromTime: NSDate?
    var toTime: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CLTPersonalAttendanceNoteViewController.refreshNote), name: "refreshNote", object: nil)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ADANDetailViewController" {
            let detailView = segue.destinationViewController as! ADANDetailViewController
            detailView.attendanceID = attendanceID
        }
    }
}

// MARK: - private Method
extension ADAttendanceNoteViewController {
    func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "考勤记录"
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    func refreshNote() {
        tableView.headerRefresh = true
    }
    
}

extension ADAttendanceNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        
        var params = [String:AnyObject]()
        if let _ = fromTime {
            params.updateValue(fromTime!.localDate(), forKey: "fromTime")
        }
        if let _ = toTime {
            params.updateValue(toTime!.localDate(), forKey: "toTime")
        }
        
        if let _ = classID {
            params.updateValue(classID!, forKey: "classID")
        }
        
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceInfosByClassID, params: params, modelType: Attendance(), listType: Attendance(), completed: { (responseData) in
            self.tableView.mj_header.endRefreshing()
            self.attendanceArrData = responseData["list"] as! [Attendance]
            self.tableView.reloadData()
        }) { [weak self] (errorMsg) in
            self?.errorNotice(errorMsg!)
            self?.tableView.mj_header.endRefreshing()
            
        }
    }
}

// MARK: - UITableViewDelegate
extension ADAttendanceNoteViewController: UITableViewDelegate {
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
        self.performSegueWithIdentifier("ADANDetailViewController", sender: nil)
        
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForAttendanceNote = "ADAttendanceNoteCell"
extension ADAttendanceNoteViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attendanceArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForAttendanceNote, forIndexPath: indexPath) as! ADAttendanceNoteCell
        let attendance = self.attendanceArrData[indexPath.row]
        cell.timeLabel.text = attendance.updateTime.stringForDateFormat("yyyy-MM-dd")
        cell.courseNameLabel.text = attendance.courseName
        cell.classNameLabel.text = attendance.className
        cell.quekeLabel.text = "\(attendance.quekeCount)"
        cell.chidaoLabel.text = "\(attendance.chidaoCount)"
        cell.zaotuiLabel.text = "\(attendance.zaotuiCount)"
        cell.qingjiaLabel.text = "\(attendance.qingjiaCount)"
        cell.teahcerLbl.text = attendance.teacherName
        
        return cell
    }
}
