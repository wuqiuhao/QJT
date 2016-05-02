//
//  SPersonalSignNoteViewController.swift
//  QJT
//
//  Created by YC on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalSignNoteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var signNoteArrData = [Attendance]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNetwork()
        tableView.delegate = self
        tableView.dataSource = self
        configUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - private Method
extension SPersonalSignNoteViewController {
    
    func configUI() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "签到记录"
        tableView.headerRefresh = true
        tableView.configRefreshDelegate = self
    }
    
    func getNetwork() {
        print("getNetwork")
    }
    
}

extension SPersonalSignNoteViewController: ConfigRefreshDelegate {
    func headerRefresh(view: UIView) {
        
        getNetwork()
        // 结束刷新
        self.tableView.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension SPersonalSignNoteViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
}

// MARK: - UITableViewDataSource
private let cellIdeitiferForSignNote = "SPersonalSignNoteCell"
extension SPersonalSignNoteViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.signNoteArrData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeitiferForSignNote, forIndexPath: indexPath) as! CLTPersonalAttendanceNoteCell
//        let attendance = self.signNoteArrData[indexPath.row]
        
        
        return cell
    }
}

















