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
        getNetWork()
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
    }
    
    func getNetWork() {
        NetWorkManager.httpRequest(Methods.leave_getLeaveInfosByTeacherID, params: ["teacherID":UserConfig.teacherSetting()!.userID,"isHistory":1], modelType: nil, listType: Leave(), completed: { (responseData) in
            self.leaveNoteDataArr = responseData["list"] as! [Leave]
            self.tableView.reloadData()
        }) { [weak self] (errorMsg) in
            self?.errorNotice(errorMsg!)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is SPersonalLNDetailViewController {
            let vc = segue.destinationViewController as! SPersonalLNDetailViewController
            let index = sender as! NSIndexPath
            vc.leave = leaveNoteDataArr[index.row]
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
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SPersonalLNDetailViewController", sender: indexPath)
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