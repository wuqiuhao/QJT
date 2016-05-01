//
//  LeaveMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/13.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit
import ObjectMapper

class LeaveMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dateArr = [Dictionary<String, String>]()
    /// 日期选择器
    var datePicker: UIDatePicker?
    var startDate = NSDate()
    var endDate = NSDate()
    var pickerSelectDate = NSDate()
    var datePickerValue: NSDate!
    var selectCourseDataArr = [CourseClass]()
    var fromTime = NSDate()
    var toTime = NSDate()
    var reason = ""
    var isFirstSelected = false
    var isSecondSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableViewData()
        configUI()
        setupItem()
    }
    
}

// MARK: - private Method
extension LeaveMainViewController {
    
    func configUI() {
        
        navigationItem.title = "请假"
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 45
    }
    
    func setupItem() {
        let rightItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func rightItemClicked() {
        var params = [String:AnyObject]()
        var uniqueID = [Int]()
        params.updateValue(UserConfig.studentSetting()!.userID, forKey: "studentID")
        params.updateValue(UserConfig.studentSetting()!.userName, forKey: "studentName")
        params.updateValue(UserConfig.studentSetting()!.className, forKey: "className")
        params.updateValue(fromTime.localDate(), forKey: "fromTime")
        params.updateValue(toTime.localDate(), forKey: "toTime")
        params.updateValue(reason, forKey: "reason")
        for data in selectCourseDataArr {
            uniqueID.append(data.courseClassUniqueID)
        }
        params.updateValue(Mapper<EmptyModel>.toJSONString(uniqueID, prettyPrint: false)!, forKey: "applyCourseJsonString")
        params.updateValue(NSDate().localDate(), forKey: "leaveTime")
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.leave_leaveApplication, params: params, modelType: EmptyModel(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            let vc = UIStoryboard(name: "SPersonal", bundle: nil).instantiateViewControllerWithIdentifier("SPersonalLeaveNoteViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            }) {[weak self](errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
        }
    }
    
    /**
     创建datePicker
     */
    func createDatePicker(index: Int) {
        datePicker = UIDatePicker()
        datePicker!.datePickerMode = .Date
        if index == 0 {
            datePicker!.minimumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: -1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            datePicker!.maximumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: 1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            datePicker!.setDate(fromTime, animated: false)
        } else if index == 1 {
            //datePicker!.minimumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: -1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            datePicker!.minimumDate = fromTime
            datePicker!.maximumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: 2).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            datePicker!.setDate(fromTime, animated: false)
        }
        datePicker!.frame = CGRect(x: 15, y: 0, width: UIScreen.mainScreen().bounds.width, height: 162)
        datePicker!.addTarget(self, action: #selector(LeaveMainViewController.datePickerValueChange), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func datePickerValueChange() {
        var i = 0
        for data in dateArr {
            if data["title"] == "datePicker" && i == 1 {
                datePickerValue = datePicker?.date
                fromTime = datePickerValue
                let dateStr = datePicker?.date.stringForDateFormat("yyyy-MM-dd")
                let weekStr = datePicker?.date.dateToWeek()
                dateArr[i - 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                dateArr[i + 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i + 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            } else if data["title"] == "datePicker" && i == 2 {
                datePickerValue = datePicker?.date
                toTime = datePickerValue
                let dateStr = datePicker?.date.stringForDateFormat("yyyy-MM-dd")
                let weekStr = datePicker?.date.dateToWeek()
                dateArr[i - 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            }
            i += 1
        }
    }
    
    /**
     创建初始数据
     */
    func createTableViewData() {
        let dateStr = pickerSelectDate.stringForDateFormat("yyyy-MM-dd")
        let weekStr = pickerSelectDate.dateToWeek()
        let cellData1 = ["title":"开始时间", "detail":"\(dateStr)  \(weekStr)"]
        let cellData2 = ["title":"结束时间","detail":"\(dateStr)  \(weekStr)"]
        let cellData3 = ["title":"课程选择","detail":"请选择请假课程"]
        let cellData4 = ["title":"请假原因","detail":"请填写请假原因"]
        dateArr = [cellData1, cellData2, cellData3,cellData4]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is LeaveReasonViewController {
            let vc = segue.destinationViewController as! LeaveReasonViewController
            vc.delegate = self
            if dateArr[3]["detail"] != "请填写请假原因" {
                vc.textViewContent = dateArr[3]["detail"]!
            }
        } else if segue.destinationViewController is LeaveCourseViewController {
            let vc = segue.destinationViewController as! LeaveCourseViewController
            vc.selectCourseDataArr = selectCourseDataArr
            vc.delegate = self
        }
    }
}

extension LeaveMainViewController: ViewControllerTransmitDelegate {
    func transmitMessage(data: [AnyObject]) {
        if data.count != 0 && data[0] is String {
            if data[0] as? String != "" {
                dateArr[3]["detail"] = data[0] as? String
            }
            reason = dateArr[3]["detail"]!
            UIView.performWithoutAnimation({ 
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            })
            
        } else {
            var detailStr = ""
            var i = 0
            for course in data {
                let model = course as! CourseClass
                if i == data.count - 1 {
                    detailStr = detailStr + model.courseName + " " + model.address + " " + model.teacherName
                } else {
                    detailStr = detailStr + model.courseName + " " + model.address + " " + model.teacherName + "\n"
                }
                i += 1
            }
            selectCourseDataArr = data as! [CourseClass]
            dateArr[2]["detail"] = detailStr
            UIView.performWithoutAnimation({ 
                self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            })
            
        }
    }
}

// MARK: - UITableViewDelegate
extension LeaveMainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch dateArr[indexPath.row]["title"]! {
        case "datePicker":
            return 162
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var i = 0
        for temp in dateArr {
            i += 1
            for (_, value) in temp {
                if value == "datePicker" {
                    removePicker(i, section: indexPath.section)
                    return
                }
            }
        }
        if indexPath.row == 0 {
            addPicker("datePicker", indexPath: indexPath)
        } else if indexPath.row == 1 {
            addPicker("datePicker", indexPath: indexPath)
        } else if indexPath.row == 2 {
            switch NSDate.judegeDateState(fromTime, end: toTime) {
            case DateState.error:
                self.errorNotice("请假时间错误！")
                return
            case DateState.beyondFive:
                self.successNotice("请假时间超出五天，无需选课！")
                return
            case DateState.withinFive:
                print("5天之内")
            }
            self.performSegueWithIdentifier("LeaveCourseViewController", sender: nil)
        } else if indexPath.row == 3 {
            self.performSegueWithIdentifier("LeaveReasonViewController", sender: nil)
        }
    }
    
}

private let cellIdentifierForLeave = "LeaveCell"
// MARK: - UITableViewDataSource
extension LeaveMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForLeave, forIndexPath: indexPath) as! LeaveCell
        cell.titleLbl.hidden = false
        cell.detailLbl.hidden = false
        switch dateArr[indexPath.row]["title"]! {
        case "开始时间":
            cell.titleLbl.text = "开始时间:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "结束时间":
            cell.titleLbl.text = "结束时间:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "课程选择":
            cell.titleLbl.text = "课程选择:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "请假原因":
            cell.titleLbl.text = "请假原因:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "datePicker":
            cell.titleLbl.hidden = true
            cell.detailLbl.hidden = true
            cell.addSubview(datePicker!)
        default:
            return cell
        }
        return cell
    }
    
    func addPicker(pickerType: String ,indexPath: NSIndexPath) {
        let nextIndexPath = NSIndexPath(forItem: indexPath.row + 1, inSection: indexPath.section)
        let cellDate = ["title":pickerType,"detail":dateArr[indexPath.row]["detail"]!]
        dateArr.insert(cellDate, atIndex: indexPath.row + 1)
        if pickerType == "datePicker" {
            createDatePicker(indexPath.row)
        }
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([nextIndexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        tableView.endUpdates()
    }
    
    func removePicker(indexPath: Int, section: Int) {
        dateArr.removeAtIndex(indexPath - 1)
        tableView.beginUpdates()
        let nextIndexPath = NSIndexPath(forItem: indexPath - 1, inSection: section)
        tableView.deleteRowsAtIndexPaths([nextIndexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        if datePicker != nil {
            datePicker?.removeFromSuperview()
        }
        tableView.endUpdates()
    }


}