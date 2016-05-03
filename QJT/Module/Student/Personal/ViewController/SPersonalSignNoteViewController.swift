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
    
}

extension SPersonalSignNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        
        NetWorkManager.httpRequest(Methods.studentGetLostAttendanceInfos, params: ["studentID":UserConfig.studentSetting()!.userID], modelType: StudentAttendanceInfo(), listType: StudentAttendanceInfo(), completed: { (responseData) in
            
            self.tableView.mj_header.endRefreshing()
            self.signNoteArrData = responseData["list"] as! [StudentAttendanceInfo]
            self.tableView.reloadData()
            
        }) { [weak self] (errorMsg) in
            self?.tableView.mj_header.endRefreshing()
            
        }
    }
}

// MARK: - UITableViewDelegate
extension SPersonalSignNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
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
        cell.teacherNameLabel.text = attendance.teacherName
        cell.quekeLabel.text = "\(attendance.queke)"
        cell.chidaoLabel.text = "\(attendance.chidao)"
        cell.zaotuiLabel.text = "\(attendance.zaotui)"
        cell.qingjiaLabel.text = "\(attendance.qingjia)"
        
        
        return cell
    }
}

















