//
//  LeaveCourseViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/23.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveCourseViewController: UIViewController {
    
    var courseView: CourseView!
    lazy var courseDataArr = [CourseClass]()
    lazy var refreshDataArr = [CourseClass]()
    lazy var selectCourseDataArr = [CourseClass]()
    var isCourseSelected: Bool = false
    var delegate: ViewControllerTransmitDelegate?
    
    let weekExcelWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5
    let partExcelHeight: CGFloat = (UIScreen.mainScreen().bounds.height - 64 - 30) / 11
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupCourseBackground()
        getNetwork()
        
    }
    
    deinit {
        print("课程表释放了!")
    }
    
}

// MARK: - private Method
extension LeaveCourseViewController {
    
    func configUI() {
        navigationItem.title = "课程表"
        let rightItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveReasonViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func getNetwork() {
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.leave_studentGetCourseClasses, params: ["studentID":"2012812025"], modelType: CourseClass(), listType: CourseClass(), completed: { (responseData) in
            self.clearAllNotice()
            self.courseDataArr = responseData["list"] as! [CourseClass]
            self.configCourseExcel()
        }) { (errorMsg) in
            self.clearAllNotice()
            print(errorMsg!)
        }
    }
    
    func setupCourseBackground() {
        courseView = CourseView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64))
        view.addSubview(courseView)
    }
    
    func rightItemClicked() {
        delegate?.transmitMessage(refreshDataArr)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func configCourseExcel() {
        var i = 0
        for course in courseDataArr {
            let offsetX = 30 + CGFloat(course.week.toInt() - 1) * weekExcelWidth + 1
            let offsetY = 30 + CGFloat(course.fromSection - 1) * partExcelHeight + 1
            let courseLbl = HLable()
            let courseHook = UIImageView()
            courseLbl.verticalAlignment = .Middle
            courseLbl.frame = CGRectMake(offsetX, offsetY, weekExcelWidth - 2, partExcelHeight * CGFloat(course.durationSection) - 2)
            courseHook.frame = CGRectMake(weekExcelWidth - 19, courseLbl.bounds.height - 17, 15, 15)
            courseHook.image = UIImage(named: "course_hook")
            
            if isSelectedChange(course) {
                courseHook.hidden = false
                courseLbl.layer.borderWidth = 2
                courseLbl.isCourseSelected = true
                refreshDataArr.append(course)
            } else {
                courseHook.hidden = true
                courseLbl.layer.borderWidth = 0
                courseLbl.isCourseSelected = false
            }
            courseLbl.text = course.courseName + "\n" + course.address + "\n" + course.teacherName
            courseLbl.backgroundColor = colorWithRandom()
            courseLbl.numberOfLines = 0
            courseLbl.font = UIFont.systemFontOfSize(14)
            courseLbl.layer.cornerRadius = 4
            courseLbl.layer.masksToBounds = true
            courseLbl.textColor = UIColor.whiteColor()
            courseLbl.layer.borderColor = UIColor.qjtTintColor().CGColor
            courseLbl.tag = i + 1000
            let tap = UITapGestureRecognizer(target: self, action: #selector(LeaveCourseViewController.courseLblClicked(_:)))
            courseLbl.addGestureRecognizer(tap)
            courseLbl.userInteractionEnabled = true
            courseLbl.addSubview(courseHook)
            courseView.addSubview(courseLbl)
            i += 1
        }
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
    
    func isSelectedChange(course: CourseClass) -> Bool {
        for data in selectCourseDataArr {
            if data.courseClassUniqueID == course.courseClassUniqueID {
                return true
            }
        }
        return false
    }
    
    func courseLblClicked(sender: UITapGestureRecognizer) {
        let courseLbl = sender.view as! HLable
        var hookImageView = UIImageView()
        let data = courseDataArr[sender.view!.tag - 1000]
        for hook in courseLbl.subviews {
            if hook is UIImageView {
                hookImageView = hook as! UIImageView
            }
        }
        if !courseLbl.isCourseSelected {
            courseLbl.layer.borderWidth = 2
            courseLbl.isCourseSelected = true
            hookImageView.hidden = false
            refreshDataArr.append(data)
        } else {
            courseLbl.layer.borderWidth = 0
            courseLbl.isCourseSelected = false
            hookImageView.hidden = true
            for i in 0..<refreshDataArr.count {
                if data.courseClassUniqueID == refreshDataArr[i].courseClassUniqueID {
                    refreshDataArr.removeAtIndex(i)
                    break
                }
            }
        }
    }
}