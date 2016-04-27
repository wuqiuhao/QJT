//
//  CTSignCourseViewController.swift
//  QJT
//
//  Created by YC on 16/4/25.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CTSignCourseViewController: UIViewController {

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
        getNetwork()
        
        self.configCourseExcel()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - private Method
extension CTSignCourseViewController {
    
    func configUI() {
        navigationItem.title = "教师课程表"
    }
    
    //获取课程表
    func getNetwork() {
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.attendance_teacherGetCourseClasses, params: ["teacherID":"2012812025"], modelType: CourseClass(), listType: CourseClass(), completed: { (responseData) in
            
            self.clearAllNotice()
            self.courseArrData = responseData["list"] as! [CourseClass]
            self.configCourseExcel()
            
        }) { (errorMsg) in
            self.clearAllNotice()
            print(errorMsg!)
        }
    }
    
    //教师发起考勤
    func startSignNetwork(courseTag: Int) {
        var params = [String:AnyObject]()
        var method = ""
        
        
        let date = NSDate()
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyyMMddHHmmss" //(格式可俺按自己需求修整)
        let strNowTime = timeFormatter.stringFromDate(date) as String
        
        
        params.updateValue("2012812025", forKey: "teacherID")
        params.updateValue("\(courseArrData[courseTag].courseClassID)", forKey: "courseClassID")
        params.updateValue(strNowTime, forKey: "attendanceTime")
        params.updateValue((self.long! as NSString).doubleValue, forKey: "longitude")
        params.updateValue((self.lat! as NSString).doubleValue, forKey: "latitude")
        
        
        method = Methods.attendance_teacherBeginClass
        
        self.pleaseWait()
        NetWorkManager.httpRequest(method, params: params, modelType: EmptyModel(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            
            let alertController = UIAlertController(title: "",
                message: "发起考勤成功", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Default,handler: {action in
                
            })
            
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            
        }) { [weak self] (errorMsg) in
            self?.clearAllNotice()
            self?.errorNotice(errorMsg!)
            
            let alertController = UIAlertController(title: "",
                                                    message: "发起考勤失败，请重新操作", preferredStyle: .Alert)
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
    //课程标签的点击相应事件
    func handleTapGesture(sender: UITapGestureRecognizer) {
        //获取当前标签
        let label =  sender.view as! UILabel
        print("\(label.tag)")
        //提示
        let alertController = UIAlertController(title: "\(label.text!)",
                                                message: "您确定现在要发起考勤吗？", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "发起", style: .Default,handler: {action in
            
            self.startSignNetwork(label.tag - 10000)
            
            
            
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
