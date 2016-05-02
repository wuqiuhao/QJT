//
//  CTLeaveMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTLeaveMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var leaveDataArr = [Leave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        print(NSLocaleIdentifier)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CLTLeaveMainViewController.refreshLeave), name: "refreshLeave", object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refreshLeave", object: nil)
    }
    
}

// MARK: - private Method
extension CLTLeaveMainViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假审核"
        tableView.tableFooterView = UIView()
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is CLTLeaveDetailViewController {
            let vc = segue.destinationViewController as! CLTLeaveDetailViewController
            let index = sender as! NSIndexPath
            vc.leave = leaveDataArr[index.row]

        }
    }
    
    func refreshLeave() {
        tableView.headerRefresh = true
    }
}

extension CLTLeaveMainViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
            NetWorkManager.httpRequest(Methods.leave_getLeaveInfosByTeacherID, params: ["teacherID":UserConfig.teacherSetting()!.userID,"isHistory":0], modelType: nil, listType: Leave(), completed: { (responseData) in
                self.leaveDataArr = responseData["list"] as! [Leave]
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
            }) { [weak self] (errorMsg) in
                self?.tableView.mj_header.endRefreshing()
                self?.errorNotice(errorMsg!)
            }
    }
}

// MARK: - UITableViewDelegate
extension CLTLeaveMainViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("CLTLeaveDetailViewController", sender: indexPath)
    }
    
}

// MARK: - UITableViewDataSource
private let cellIdeiferForLeaveCell = "CLTLeaveMainCell"
extension CLTLeaveMainViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveDataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeiferForLeaveCell, forIndexPath: indexPath) as! CLTLeaveMainCell
        cell.model = leaveDataArr[indexPath.row]
        return cell
    }
}