//
//  SPersonalLeaveNoteViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/28.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalLeaveNoteViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var leaveNoteDataArr = [Leave]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - private Method
extension SPersonalLeaveNoteViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假记录"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SPersonalLNDetailViewController {
            let vc = segue.destinationViewController as! SPersonalLNDetailViewController
            let index = sender as! NSIndexPath
            vc.leaveID = leaveNoteDataArr[index.row].leaveID
        }
    }
}

extension SPersonalLeaveNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        NetWorkManager.httpRequest(Methods.leave_getLeaveInfosByStudentID, params: ["studentID":UserConfig.studentSetting()!.userID], modelType: EmptyModel(), listType: Leave(), completed: { (responseData) in
            self.leaveNoteDataArr = responseData["list"] as! [Leave]
            self.tableView.mj_header.endRefreshing()
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            self.tableView.reloadData()
        }) { [weak self] (errorMsg) in
            self?.errorNotice(errorMsg!)
            self?.tableView.mj_header.endRefreshing()
        }

    }
}

// MARK: - UITableViewDelegate
extension SPersonalLeaveNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SPersonalLNDetailViewController", sender: indexPath)
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForLeaveNote = "SPersonalLeaveNoteCell"
extension SPersonalLeaveNoteViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveNoteDataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForLeaveNote, forIndexPath: indexPath) as! SPersonalLeaveNoteCell
        cell.model = leaveNoteDataArr[indexPath.row]
        return cell
    }
}

// MARK: - DZNEmptyDataSetSource
extension SPersonalLeaveNoteViewController: DZNEmptyDataSetSource {
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        var text : String!
        text = "还没有请假申请记录"
        let font = UIFont.systemFontOfSize(16.0)
        let textColor = UIColor.lightGrayColor()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5
        paragraph.alignment = NSTextAlignment.Center
        return NSAttributedString(string: text, attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : textColor,NSParagraphStyleAttributeName : paragraph])    }
}

// MARK: - DZNEmptyDataSetDelegate
extension SPersonalLeaveNoteViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
}