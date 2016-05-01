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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
}

// MARK: - private Method
extension CLTLeaveMainViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "请假审核"
        tableView.tableFooterView = UIView()
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
        self.performSegueWithIdentifier("CLTLeaveDetailViewController", sender: nil)
    }
    
}

// MARK: - UITableViewDataSource
private let cellIdeiferForLeaveCell = "CLTLeaveMainCell"
extension CLTLeaveMainViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeiferForLeaveCell, forIndexPath: indexPath) as! CLTLeaveMainCell
        
        return cell
    }
}