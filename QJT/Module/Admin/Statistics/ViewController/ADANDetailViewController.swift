//
//  ADANDetailViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class ADANDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var attDetailArrData = [AttendanceDetail]()
    lazy var tempAttDetailArrData = [AttendanceDetail]()
    var attendanceID: Int!
    var tempAttDetail: AttendanceDetail!
    var rowInTable: Int!
    var tempRow: Int!
    let statusArr = ["缺课","迟到","早退","请假","出勤"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        getNetwork()
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refreshNote", object: nil)
    }
    
}

extension ADANDetailViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceDetailInfo, params: ["attendanceID":attendanceID], modelType: AttendanceDetail(), listType: AttendanceDetail(), completed: { (responseData) in
            self.tableView.mj_header.endRefreshing()
            self.attDetailArrData = responseData["list"] as! [AttendanceDetail]
            self.tableView.reloadData()
        }) { (errorMsg) in
            self.tableView.mj_header.endRefreshing()
            self.errorNotice(errorMsg!)
            
        }
    }
}

// MARK: - private Method
extension ADANDetailViewController {
    func configUI() {
        navigationItem.title = "考勤明细"
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    func getNetwork() {
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceDetailInfo, params: ["attendanceID":attendanceID], modelType: AttendanceDetail(), listType: AttendanceDetail(), completed: { (responseData) in
            
            self.clearAllNotice()
            self.attDetailArrData = responseData["list"] as! [AttendanceDetail]
            self.tableView.reloadData()
            
        }) { (errorMsg) in
            self.clearAllNotice()
            print(errorMsg!)
            
        }
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


// MARK: - UITableViewDelegate
extension ADANDetailViewController: UITableViewDelegate {
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
private let cellIdeitiferForANDetail = "ADANDetailCell"
extension ADANDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attDetailArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForANDetail, forIndexPath: indexPath) as! ADANDetailCell
        let attDetail = self.attDetailArrData[indexPath.row]
        cell.studentNameLabel.text = attDetail.studentName
        cell.studentIDLabel.text = attDetail.studentID
        cell.statusLabel.text = getStatusStr(attDetail.queke, chidao: attDetail.chidao, zaotui: attDetail.zaotui, qingjia: attDetail.qingjia)
        
        return cell
    }
    
}
