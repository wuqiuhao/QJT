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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableViewData()
        configUI()
    }
}

// MARK: - private Method
extension ADStatisticsViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 45
    }
    
    func createTableViewData() {
        let cellData1 = ["title":"所在分院", "detail":"请选择分院"]
        let cellData2 = ["title":"所在专业","detail":"请选择专业"]
        let cellData3 = ["title":"开始时间","detail":"请选择开始时间"]
        let cellData4 = ["title":"结束时间","detail":"请选择结束时间"]
        dateArr = [cellData1, cellData2, cellData3,cellData4]
    }
}

// MARK: - UITableViewDelegate
extension ADStatisticsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
        case "所在分院":
            cell.titleLbl.text = "所在分院:"
            cell.detailLbl.text = dateArr[indexPath.row]["detail"]
        case "所在专业":
            cell.titleLbl.text = "所在专业:"
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
            //cell.addSubview(datePicker!)
        default:
            return cell
        }

        return cell
    }
}