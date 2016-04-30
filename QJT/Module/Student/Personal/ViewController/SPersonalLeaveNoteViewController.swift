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
extension SPersonalLeaveNoteViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假记录"
    }
    
    func getNetWork() {
        NetWorkManager.httpRequest(Methods.leave_getLeaveInfosByStudentID, params: ["studentID":UserConfig.studentSetting()!.userID], modelType: nil, listType: Leave(), completed: { (responseData) in
            let result = responseData["List"] as! [Leave]
            print(result)
            }) { [weak self] (errorMsg) in
                self?.errorNotice(errorMsg!)
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
        //self.performSegueWithIdentifier("SPersonalLNDetailViewController", sender: nil)
        let vc = UIStoryboard(name: "SPersonal", bundle: nil).instantiateViewControllerWithIdentifier("SPersonalLNDetailViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForLeaveNote = "SPersonalLeaveNoteCell"
extension SPersonalLeaveNoteViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForLeaveNote, forIndexPath: indexPath)
        return cell
    }
}