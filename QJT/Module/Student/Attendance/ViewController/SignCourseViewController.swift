//
//  SignCourseViewController.swift
//  QJT
//
//  Created by YC on 16/4/24.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SignCourseViewController: UIViewController {

    var lat: Double!
    var long: Double!
    var labelTag = 10000
    var courseView: CourseView!
    lazy var courseArrData = [CourseClass]()
    
    let weekExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCourseBackground()
        getNetwork()
        
        self.configCourseExcel()
        
    }

}

// MARK: - private Method
extension SignCourseViewController {
    
    func configUI() {
        navigationItem.title = "课程表"
    }
    
    func getNetwork() {
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.leave_studentGetCourseClasses, params: ["studentID":"\(UserConfig.studentSetting()!.userID)"], modelType: CourseClass(), listType: CourseClass(), completed: { (responseData) in
            
            self.clearAllNotice()
            self.courseArrData = responseData["list"] as! [CourseClass]
            self.configCourseExcel()
            
        }) { (errorMsg) in
            self.clearAllNotice()
            print(errorMsg!)
        }
    }
    
    func signNetwork(courseTag: Int) {
        var params = [String:AnyObject]()
        var method = ""
        
        params.updateValue("\(UserConfig.studentSetting()!.userID)", forKey: "studentID")
        params.updateValue("\(courseArrData[courseTag].courseClassID)", forKey: "courseClassID")
        params.updateValue(NSDate(), forKey: "signTime")
        params.updateValue(long, forKey: "longitude")
        params.updateValue(lat, forKey: "latitude")
        
        
        method = Methods.attendance_studentAttendance
        
        self.pleaseWait()
        NetWorkManager.httpRequest(method, params: params, modelType: EmptyModel(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            
            self.successNotice("签到成功")
            
            
        }) { [weak self] (errorMsg) in
            self?.clearAllNotice()
            self?.errorNotice(errorMsg!)
            
        }
    }
    
    func setupCourseBackground() {
        courseView = CourseView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64))
        self.view.addSubview(courseView)
    }
    
    func configCourseExcel() {
        for course in courseArrData {
            let offsetX = 30 + CGFloat(course.week.toInt() - 1) * weekExcelWidth + 1
            let offsetY = 30 + CGFloat(course.fromSection - 1) * partExcelHeight + 1
            let courseLbl = HLable()
            courseLbl.verticalAlignment = .Middle
            courseLbl.frame = CGRectMake(offsetX, offsetY, weekExcelWidth - 2, partExcelHeight * CGFloat(course.durationSection) - 2)
            courseLbl.text = course.courseName + "\n" + course.address
            courseLbl.backgroundColor = colorWithRandom()
            courseLbl.numberOfLines = 0
            courseLbl.font = UIFont.systemFontOfSize(14)
            courseLbl.layer.cornerRadius = 4
            courseLbl.layer.masksToBounds = true
            courseLbl.textColor = UIColor.whiteColor()
            
            courseLbl.tag = labelTag
            labelTag += 1
            courseLbl.userInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignCourseViewController.handleTapGesture(_:)))
            //设置手势点击数,双击：点1下
            tapGesture.numberOfTapsRequired = 1
            courseLbl.addGestureRecognizer(tapGesture)
            
            
            courseView.addSubview(courseLbl)
        }
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) {
        
        let label =  sender.view as! UILabel
        
        print("\(label.tag)")
        
        let alertController = UIAlertController(title: "\(label.text!)",
                                                message: "您确定现在要签到吗？", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "签到", style: .Default,handler: {action in
            
            self.signNetwork(label.tag - 10000)
            
            
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    func colorWithRandom() -> UIColor {
        let redNum = random() % 255
        let greenNum = random() % 255
        let blueNum = random() % 255
        if redNum < 200 || greenNum < 200 || blueNum < 200 {
            return UIColor(red: CGFloat(redNum)/255, green: CGFloat(greenNum)/255, blue: CGFloat(blueNum)/255, alpha: 0.7)
        } else {
            return colorWithRandom()
        }
    }
}
