//
//  CLTLeaveDetailViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/1.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTLeaveDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var verifyBtn: UIButton!
    
    var dataArr = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupBtn()
        perpareData()
    }
}

// MARK: - private Method
extension CLTLeaveDetailViewController {
    func configUI() {
        tableView.estimatedRowHeight = 100
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func perpareData() {
        let data = ["title":"审核状态:","detail":"请选择"]
        dataArr.append(data)
    }
    
    func setupBtn() {
        verifyBtn.layer.cornerRadius = 4
        verifyBtn.clipsToBounds = true
        verifyBtn.addTarget(self, action: #selector(CLTLeaveDetailViewController.verifyBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func verifyBtnClicked() {
        
    }
}

// MARK: - UITableViewDelegate
extension CLTLeaveDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            let alertVC = UIAlertController(title: "审核结果", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
            let passAction = UIAlertAction(title: "通过", style: UIAlertActionStyle.Default, handler: { (action) in
                self.dataArr[0].updateValue("通过", forKey: "detail")
                if self.dataArr.count == 1 {
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 3, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                } else if self.dataArr.count == 2 {
                    self.dataArr.removeAtIndex(1)
                    self.tableView.reloadData()
                }
                
            })
            let unPassAction = UIAlertAction(title: "不通过", style: UIAlertActionStyle.Destructive, handler: { (action) in
                self.dataArr[0].updateValue("不通过", forKey: "detail")
                if self.dataArr.count == 1 {
                    let reason = ["title":"拒绝原因:","detail":"请填写拒绝原因"]
                    self.dataArr.append(reason)
                }
                self.tableView.reloadData()
            })
            alertVC.addAction(passAction)
            alertVC.addAction(unPassAction)
            self.presentViewController(alertVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForDetail = "CLTLeaveDetailCell"
extension CLTLeaveDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForDetail, forIndexPath: indexPath) as! CLTLeaveDetailCell
        switch indexPath.row {
        case 0:
            cell.titleLbl.text = "请假时间:"
            cell.detailLbl.text = "2016.4.20 - 2016.4.23"
        case 1:
            cell.titleLbl.text = "请假学生:"
            cell.detailLbl.text = "李泽强"
        case 2:
            cell.titleLbl.text = "请假课程:"
            cell.detailLbl.text = "返回房间爱开始疯狂聚划算的空间和电视剧看更好的飞机开始过圣诞节会感觉到施工快捷的师傅搞空间大帅哥会计师的花费高科技的"
        case 3:
            cell.titleLbl.text = dataArr[0]["title"]
            cell.detailLbl.text = dataArr[0]["detail"]
        case 4:
            cell.titleLbl.text = dataArr[1]["title"]
            cell.detailLbl.text = dataArr[1]["detail"]
        default:
            return UITableViewCell()
        }
        return cell
    }
}