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
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupItem() {
        
        let rightItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
        
        let leftItem = UIBarButtonItem(title: "历史记录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.leftItemClicked))
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func rightItemClicked() {
        let vc = UIStoryboard(name: "Leave", bundle: nil).instantiateViewControllerWithIdentifier("LeaveCourseViewController")
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
        //datePicker!.addTarget(self, action: #selector(ScheduleViewController.datePickerValueChange), forControlEvents: UIControlEvents.ValueChanged)
        datePicker?.setDate(pickerSelectDate, animated: false)
    }
    
    /**
     创建tableView数据
     */
    func createTableViewData() {
        let dateStr = pickerSelectDate.stringForDateFormat("yyyy-MM-dd")
        let weekStr = pickerSelectDate.dateToWeek()
        let cellData1 = ["title":"datePicker", "detail":"\(dateStr)  \(weekStr)"]
        let cellData2 = ["title":"datePicker","detail":"\(dateStr)  \(weekStr)"]
        dateArr = [cellData1, cellData2]
    }
}

extension LeaveMainViewController: UITableViewDelegate {
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //       return 45
    //    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var i = 0
        for temp in dateArr {
            i += 1
            for (_, value) in temp {
                if value == "datePicker" || value == "timePicker" || value == "durationPicker" {
                    removePicker(i, section: indexPath.section)
                    return
                }
            }
        }
        if indexPath.row == 0 {
            addPicker("datePicker", indexPath: indexPath)
        }
    }
    
}
private let cellIdentifierForLeave = "LeaveCell"
extension LeaveMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArr.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForLeave, forIndexPath: indexPath) as! LeaveCell
        for subView in cell.contentView.subviews {
            if subView is UILabel == false {
                subView.removeFromSuperview()
            }
        }
//        cell.selectionStyle = .None
//        if dateArr[indexPath.row]["title"] == "datePicker" {
//            //cell.addSubview(datePicker!)
//        }
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