//
//  CLTPersonalANDetailViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTPersonalANDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var attDetailArrData = [AttendanceDetail]()
    var attendanceID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        getNetwork()
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
extension CLTPersonalANDetailViewController {
    func configUI() {
        //        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "考勤明细"
        
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
            statusStr.appendString("缺课;")
        }else if chidao == 1 {
            statusStr.appendString("迟到;")
        }else if zaotui == 1 {
            statusStr.appendString("早退;")
        }else if qingjia == 1 {
            statusStr.appendString("请假;")
        }
        
        return (statusStr as String)
    }
    
}

// MARK: - UITableViewDelegate
extension CLTPersonalANDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForANDetail = "CLTPersonalANDetailCell"
extension CLTPersonalANDetailViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attDetailArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForANDetail, forIndexPath: indexPath) as! CLTPersonalANDetailCell
        let attDetail = self.attDetailArrData[indexPath.row]
        cell.studentNameLabel.text = attDetail.studentName
        cell.studentIDLabel.text = attDetail.studentID
        cell.statusLabel.text = getStatusStr(attDetail.queke, chidao: attDetail.chidao, zaotui: attDetail.zaotui, qingjia: attDetail.qingjia)
        
        return cell
    }
    
    
    
}


