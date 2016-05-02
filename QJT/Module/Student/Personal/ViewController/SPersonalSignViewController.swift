//
//  SPersonalSignViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalSignViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - private Method
extension SPersonalSignViewController {
    
    func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "签到记录"
    }
    
//    func getNetwork() {
//        NetWorkManager.httpRequest(Methods.attendance_getAttendanceInfosByTeacherID, params: ["teacherID":"\(UserConfig.teacherSetting()?.userID)"], modelType: Attendance(), listType: Attendance(), completed: { (responseData) in
//            
//            self.clearAllNotice()
//            self.attendanceArrData = responseData["list"] as! [Attendance]
//            
//            }) { (errorMsg) in
//                self.clearAllNotice()
//                print(errorMsg!)
//
//        }
//    }
    
}