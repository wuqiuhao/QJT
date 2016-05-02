//
//  LStatisticsViewController.swift
//  QJT
//
//  Created by wuqiuhao on 16/4/28.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class ADStatisticsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dateArr = [Dictionary<String, String>]()
    var datePicker: UIDatePicker?
    var professionPicker: UIPickerView?
    var datePickerValue: NSDate!
    var professionTitleArr = [String]()
    var classDataArr = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableViewData()
        configUI()
        getNetworkData()
    }
}

// MARK: - private Method
extension ADStatisticsViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 45
        tableView.separatorStyle = .None
        navigationItem.title = "统计"
        
        let rightItem = UIBarButtonItem(title: "查询", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ADStatisticsViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func createTableViewData() {
        let dateStr = NSDate().stringForDateFormat("yyyy-MM-dd")
        let weekStr = NSDate().dateToWeek()
        let cellData1 = ["title":"分院专业", "detail":"请选择专业"]
        let cellData2 = ["title":"开始时间","detail":"\(dateStr) \(weekStr)"]
        let cellData3 = ["title":"结束时间","detail":"\(dateStr) \(weekStr)"]
        dateArr = [cellData1, cellData2, cellData3]
        professionTitleArr = ["计算机科学与技术","机械","电子","工业设计","自动化","大环境","大会及单号","fhsdjhf"]
    }
    
    func rightItemClicked() {
        
    }
    
    func getNetworkData() {
        NetWorkManager.httpRequest(Methods.attendance_getClassesByDepartmentID, params: ["departmentID":UserConfig.teacherSetting()!.departmentID], modelType: nil, listType: Class(), completed: { (responseData) in
            self.classDataArr = responseData["list"] as! [Class]
            self.dateArr[0]["detail"] = self.classDataArr[0].className
            self.tableView.reloadData()
            }) { (errorMsg) in
                
        }
    }
    
    /**
     创建datePicker
     */
    func createDatePicker(index: Int) {
        datePicker = UIDatePicker()
        datePicker!.datePickerMode = .Date
        if index == 1 {
            datePicker!.minimumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: -1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            datePicker!.maximumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: 1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            //datePicker!.setDate(fromTime, animated: false)
        } else if index == 2 {
            //datePicker!.minimumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: -1).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            //datePicker!.minimumDate = fromTime
            datePicker!.maximumDate = NSDate.dateFromString(NSDate().getEarlyOrLaterMonthFromDate(NSDate(), month: 2).stringForDateFormat("yyyy-MM-dd"), dateformatter: "yyyy-MM-dd")
            //datePicker!.setDate(fromTime, animated: false)
        }
        datePicker!.frame = CGRect(x: 15, y: 0, width: UIScreen.mainScreen().bounds.width, height: 162)
        datePicker!.addTarget(self, action: #selector(LeaveMainViewController.datePickerValueChange), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func createProfessionPicker(index: Int) {
        professionPicker = UIPickerView()
        professionPicker?.delegate = self
        professionPicker?.dataSource = self
        professionPicker?.frame = CGRect(x: 15, y: 0, width: UIScreen.mainScreen().bounds.width, height: 162)
    }
    
    
    
    func datePickerValueChange() {
        var i = 0
        for data in dateArr {
            if data["title"] == "datePicker" && i == 2 {
                datePickerValue = datePicker?.date
                //fromTime = datePickerValue
                let dateStr = datePicker?.date.stringForDateFormat("yyyy-MM-dd")
                let weekStr = datePicker?.date.dateToWeek()
                dateArr[i - 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                //dateArr[i + 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                //tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i + 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            } else if data["title"] == "datePicker" && i == 3 {
                datePickerValue = datePicker?.date
                //toTime = datePickerValue
                let dateStr = datePicker?.date.stringForDateFormat("yyyy-MM-dd")
                let weekStr = datePicker?.date.dateToWeek()
                dateArr[i - 1].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
                tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: i - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            }
            i += 1
        }
    }
}

// MARK: - UIPickerViewDataSource
extension ADStatisticsViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classDataArr.count
    }
}

// MARK: - UIPickerViewDelegate
extension ADStatisticsViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateArr[0]["detail"] = classDataArr[row].className
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classDataArr[row].className
//        return "123123fgdsjhdjsak"
    }
}

// MARK: - UITableViewDelegate
extension ADStatisticsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch dateArr[indexPath.row]["title"]! {
        case "datePicker":
            return 162
        case "profession":
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
                } else if value == "profession" {
                    removePicker(i, section: indexPath.section)
                    return
                }
            }
        }
        if indexPath.row == 0 {
            addPicker("profession", indexPath: indexPath)
        } else if indexPath.row == 1 {
            addPicker("datePicker", indexPath: indexPath)
        } else if indexPath.row == 2 {
            addPicker("datePicker", indexPath: indexPath)
        }
    }

}

// MARK: - UITableViewDataSource
private let cellIdeitiferForADCell = "ADStatisticsTableViewCell"
extension ADStatisticsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForADCell, forIndexPath: indexPath) as! ADStatisticsTableViewCell
        cell.titleLbl.hidden = false
        cell.detailLbl.hidden = false
        switch dateArr[indexPath.row]["title"]! {
        case "分院专业":
            cell.titleLbl.text = "分院专业:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "开始时间":
            cell.titleLbl.text = "开始时间:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "结束时间":
            cell.titleLbl.text = "结束时间:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "datePicker":
            cell.titleLbl.hidden = true
            cell.detailLbl.hidden = true
            cell.addSubview(datePicker!)
        case "profession":
            cell.titleLbl.hidden = true
            cell.detailLbl.hidden = true
            cell.addSubview(professionPicker!)
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
        } else if pickerType == "profession" {
            createProfessionPicker(indexPath.row)
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
        if professionPicker != nil {
            professionPicker?.removeFromSuperview()
        }
        tableView.endUpdates()
    }
}