//
//  CLTPersonalLeaveNoteViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CLTPersonalLeaveNoteViewController: UIViewController {

    
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
extension CLTPersonalLeaveNoteViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "审核记录"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SPersonalLNDetailViewController {
            let vc = segue.destinationViewController as! SPersonalLNDetailViewController
            let index = sender as! NSIndexPath
            vc.leave = leaveNoteDataArr[index.row]
        }
    }
    

}

extension CLTPersonalLeaveNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        NetWorkManager.httpRequest(Methods.leave_getLeaveInfosByTeacherID, params: ["teacherID":UserConfig.teacherSetting()!.userID,"isHistory":1], modelType: EmptyModel(), listType: Leave(), completed: { (responseData) in
            self.leaveNoteDataArr = responseData["list"] as! [Leave]
            self.tableView.mj_header.endRefreshing()
            self.tableView.emptyDataSetSource = self
            self.tableView.emptyDataSetDelegate = self
            self.tableView.reloadData()
        }) { [weak self] (errorMsg) in
            self?.tableView.mj_header.endRefreshing()
            self?.errorNotice(errorMsg!)
        }
    }
}

// MARK: - UITableViewDelegate
extension CLTPersonalLeaveNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "CLTLeave", bundle: nil).instantiateViewControllerWithIdentifier("CLTLeaveDetailViewController") as! CLTLeaveDetailViewController
        vc.isHistory = true
        vc.leaveID = leaveNoteDataArr[indexPath.row].leaveID
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForLeaveNote = "CLTPersonalLeaveNoteCell"
extension CLTPersonalLeaveNoteViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveNoteDataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForLeaveNote, forIndexPath: indexPath) as! CLTPersonalLeaveNoteCell
        cell.model = leaveNoteDataArr[indexPath.row]
        return cell
    }
}

// MARK: - DZNEmptyDataSetSource
extension CLTPersonalLeaveNoteViewController: DZNEmptyDataSetSource {
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        var text : String!
        text = "还没有请假审核记录"
        
        let font = UIFont.systemFontOfSize(16.0)
        let textColor = UIColor.lightGrayColor()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5
        paragraph.alignment = NSTextAlignment.Center
        return NSAttributedString(string: text, attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : textColor,NSParagraphStyleAttributeName : paragraph])    }
}

// MARK: - DZNEmptyDataSetDelegate
extension CLTPersonalLeaveNoteViewController: DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
}