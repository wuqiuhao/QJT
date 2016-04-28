//
//  LeaveReasonViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/27.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveReasonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contentHeight:CGFloat?
    var textViewMaxHeight:CGFloat?
    var textViewMinHeight:CGFloat = 150
    var textViewContent = ""
    var delegate: ViewControllerTransmitDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyBoardDidShow:", object: nil)
    }
}

// MARK: - private Method
extension LeaveReasonViewController {
    func configUI() {
        self.automaticallyAdjustsScrollViewInsets = false
        let rightItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LeaveReasonViewController.rightItemClicked))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func setupData() {
        textViewMaxHeight = textViewMinHeight
        contentHeight = textViewMinHeight
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeaveReasonViewController.keyBoardDidShow(_:)), name: UIKeyboardDidShowNotification , object: nil)
    }
    
    func keyBoardDidShow(notification:NSNotification) {
        let info = notification.userInfo
        let endRect = info![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        textViewMaxHeight = UIScreen.mainScreen().bounds.height - endRect.height - 74
    }
    
    func rightItemClicked() {
        delegate?.transmitMessage([textViewContent])
        navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - UITableViewDelegate
extension LeaveReasonViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if contentHeight! < textViewMinHeight {
            contentHeight! = textViewMinHeight
        } else if contentHeight! >= textViewMaxHeight {
            contentHeight! = textViewMaxHeight!
        }
        return contentHeight!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "请假原因"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
}

// MARK: - UITableViewDataSource
private let cellIdeifierForReason = "LeaveReasonCell"
extension LeaveReasonViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdeifierForReason, forIndexPath: indexPath) as! LeaveReasonCell
        cell.initCellData(textViewContent)
        cell.parentVC = self
        return cell
    }
}