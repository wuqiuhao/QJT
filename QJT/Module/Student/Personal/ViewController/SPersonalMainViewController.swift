//
//  PersonalMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var headerView: TableViewHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

// MARK: - private Method
extension SPersonalMainViewController {
    
    func configUI() {
        tableView.tableFooterView = UIView()
        headerView = TableViewHeaderView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 250))
//        headerView.delegate = self
        headerView.dataSource = self
        tableView.tableHeaderView = headerView
        headerView.backgroundImage = UIImage(named: "1")
        headerView.reloadData()
    }
    
}

// MARK: - TableViewHeaderViewDelegate
//extension SPersonalMainViewController: TableViewHeaderViewDelegate {
//    func tableViewDuringScrollingAnnimation(contentView: TableHeaderContentView, offset: CGPoint) {
//        headerView.reloadData()
//    }
//}

// MARK: - TableViewHeaderViewDataSource
extension SPersonalMainViewController: TableViewHeaderViewDataSource {
    func tableHeaderView(tableHeaderView: UIView) -> UIView {
        
        let contentView = SPersonalHeadContentView(frame: tableHeaderView.frame)
        contentView.configConstraintes()
        return contentView
    }
}

// MARK: - UITableViewDelegate
extension SPersonalMainViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
           headerView.layoutHeaderView(scrollView.contentOffset)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("SPersonalLeaveNoteViewController", sender: nil)
        case 1:
            self.performSegueWithIdentifier("SPersonalSignViewController", sender: nil)
        case 2:
            //self.performSegueWithIdentifier("SPersonalMainViewController", sender: nil)
            let vc = UIStoryboard(name: "SPersonal", bundle: nil).instantiateViewControllerWithIdentifier("SPersonalAccontViewController")
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}

// MARK: - UITableViewDataSource
extension SPersonalMainViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SPersonMainCell", forIndexPath: indexPath) as! SPersonMainCell
        switch indexPath.row {
        case 0:
            cell.typeImg.image = UIImage(named: "SPersonal_leave")
            cell.titleLbl.text = "请假记录"
        case 1:
            cell.typeImg.image = UIImage(named: "SPersonal_attendance")
            cell.titleLbl.text = "签到记录"
        case 2:
            cell.typeImg.image = UIImage(named: "SPersonal_account")
            cell.titleLbl.text = "账号安全"
        default:
            print("")
        }
        return cell
    }
}
