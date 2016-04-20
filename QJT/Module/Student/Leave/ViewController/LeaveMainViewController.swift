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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    func setupItem() {
        
        let rightItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
        
        let leftItem = UIBarButtonItem(title: "历史记录", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveMainViewController.leftItemClicked))
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func rightItemClicked() {
        print("下一步")
    }
    
    func leftItemClicked() {
        print("历史记录")
    }
    
}

extension LeaveMainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 50
        case 1:
            return 300
        default:
            return 40
        }
    }
    
}
private let cellIdentifierForTime = "LeaveTimeCell"
private let cellIdentifierForCourse = "LeaveCourseCell"
private let cellIdentifierForBtn = "LeaveNextCell"
extension LeaveMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForTime, forIndexPath: indexPath) as! LeaveTimeCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifierForCourse, forIndexPath: indexPath) as! LeaveCourseCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}