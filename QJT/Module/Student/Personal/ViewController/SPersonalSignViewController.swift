//
//  SPersonalSignViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalSignViewController: UIViewController {

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
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func getNetwork() {
        NetWorkManager.httpRequest(Methods.attendance_getAttendanceInfosByTeacherID, params: ["":""], modelType: Attendance(), listType: Attendance(), completed: { (responseData) in
            <#code#>
            }) { (errorMsg) in
                <#code#>
        }
    }
    
}