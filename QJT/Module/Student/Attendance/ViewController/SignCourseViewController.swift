//
//  SignCourseViewController.swift
//  QJT
//
//  Created by YC on 16/4/24.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SignCourseViewController: UIViewController {

    var lat: String?
    var long: String?
    var labelTag = 10000
    var courseView: CourseView!
    lazy var courseArrData = [CourseClass]()
    
    let weekExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCourseBackground()
//        getNetwork()
        
        print("\(self.lat!):\(self.long!)")
        
        let model = CourseClass()
        model.address = "B-301"
        model.courseClassID = 104
        model.week = Week.Tuesday
        model.fromSection = 1
        model.durationSection = 2
        model.courseName = "C语言设计"
        courseArrData.append(model)
    
        let model1 = CourseClass()
        model1.address = "B-301"
        model1.courseClassID = 104
        model1.week = Week.Friday
        model1.fromSection = 7
        model1.durationSection = 3
        model1.courseName = "C语言设计"
        courseArrData.append(model1)
        
        let model2 = CourseClass()
        model2.address = "B-301"
        model2.courseClassID = 104
        model2.week = Week.Monday
        model2.fromSection = 7
        model2.durationSection = 3
        model2.courseName = "C语言设计"
        courseArrData.append(model2)
        
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
        NetWorkManager.httpRequest(Methods.leave_studentGetCourseClasses, params: ["studentID":"2012812025"], modelType: CourseClass(), listType: CourseClass(), completed: { (responseData) in
            
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
        params.updateValue("2012812025", forKey: "studentID")
        params.updateValue("\(courseArrData[courseTag].courseClassID)", forKey: "courseClassID")
        params.updateValue("\(self.long)", forKey: "longitude")
        params.updateValue("\(self.lat)", forKey: "latitude")
        
        
        method = Methods.attendance_studentAttendance
        
        self.pleaseWait()
        NetWorkManager.httpRequest(method, params: params, modelType: EmptyModel(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            
            let alertController = UIAlertController(title: "",
                message: "签到成功", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Default,handler: {action in
                
            })
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }) { [weak self] (errorMsg) in
            self?.clearAllNotice()
            self?.errorNotice(errorMsg!)
            
            let alertController = UIAlertController(title: "",
                                                    message: "签到失败", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Default,handler: {action in
                
            })
            
            alertController.addAction(okAction)
            self!.presentViewController(alertController, animated: true, completion: nil)
            
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
            
            self.signNetwork(label.tag - self.labelTag)
            
            
            
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
