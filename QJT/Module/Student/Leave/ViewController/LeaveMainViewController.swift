//
//  LeaveMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/13.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveMainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dateArr = [Dictionary<String, String>]()
    /// 日期选择器
    var datePicker: UIDatePicker?
    var startDate: NSDate!
    var endDate: NSDate!
    var pickerSelectDate = NSDate()
    var datePickerValue: NSDate!
    
    
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
        tableView.estimatedRowHeight = 150
    }
    
    func setupItem() {
        
        let rightItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
        
        let leftItem = UIBarButtonItem(title: "历史记录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.leftItemClicked))
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func rightItemClicked() {
        let vc = UIStoryboard(name: "SLeave", bundle: nil).instantiateViewControllerWithIdentifier("LeaveCourseViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func leftItemClicked() {
        
    }
    
    /**
     创建datePicker
     */
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .Date
        datePicker?.minimumDate = NSDate.dateFromString("2016-4-20", dateformatter: "yyyy-MM-dd")
        datePicker?.maximumDate = NSDate.dateFromString("2016-5-20", dateformatter: "yyyy-MM-dd")
        datePicker!.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width - 10, height: 162)
        datePicker!.addTarget(self, action: #selector(LeaveMainViewController.datePickerValueChange), forControlEvents: UIControlEvents.ValueChanged)
        datePicker?.setDate(pickerSelectDate, animated: false)
    }
    
    func datePickerValueChange() {
        datePickerValue = datePicker?.date
        pickerSelectDate = datePickerValue
        let dateStr = datePicker?.date.stringForDateFormat("yyyy-MM-dd")
        let weekStr = datePicker?.date.dateToWeek()
        dateArr[0].updateValue("\(dateStr!)  \(weekStr!)", forKey: "detail")
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
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
        dateArr = [cellData1, cellData2, cellData3]
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
        case "datePicker":
            for subView in cell.subviews {
                subView.removeFromSuperview()
            }
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
            createDatePicker()
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