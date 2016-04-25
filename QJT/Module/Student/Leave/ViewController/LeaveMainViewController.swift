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
        //datePicker!.datePickerMode = .Date
        datePicker?.setDate(pickerSelectDate, animated: false)
    }
    
    /**
     创建tableView数据
     */
    func createTableViewData() {
        let dateStr = pickerSelectDate.stringForDateFormat("yyyy-MM-dd")
        let weekStr = pickerSelectDate.dateToWeek()
        let cellData1 = ["title":"日期", "detail":"\(dateStr)  \(weekStr)"]
        let cellData2 = ["title":"开始时间","detail":"\(dateStr)  \(weekStr)"]
        dateArr = [cellData1, cellData2]
    }
}

extension LeaveMainViewController: UITableViewDelegate {
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //       return 45
    //    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            createDatePicker()
            let alertVC = UIAlertController(title: "\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alertVC.view.backgroundColor = UIColor.clearColor()
            alertVC.view.addSubview(datePicker!)
            self.presentViewController(alertVC, animated: true, completion: nil)
        default:
            print("")
        }
    }
    
}
private let cellIdentifierForLeave = "LeaveCell"
extension LeaveMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForLeave, forIndexPath: indexPath) as! LeaveCell
        switch indexPath.row {
        case 0:
            //            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForLeave, forIndexPath: indexPath) as! LeaveCell
            cell.titleLbl.text = "开始时间:"
        case 1:
            cell.titleLbl.text = "结束时间:"
        case 2:
            cell.titleLbl.text = "选择课程:"
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
}