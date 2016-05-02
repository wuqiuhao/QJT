//
//  LPersonalMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/20.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class ADPersonalMainViewController: UIViewController {

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
extension ADPersonalMainViewController {
    
    func configUI() {
        tableView.tableFooterView = UIView()
        headerView = TableViewHeaderView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height * 0.392 - 44))
        headerView.dataSource = self
        tableView.tableHeaderView = headerView
        headerView.backgroundImage = UIImage(named: "1")
        headerView.reloadData()
    }    
}

// MARK: - TableViewHeaderViewDataSource
extension ADPersonalMainViewController: TableViewHeaderViewDataSource {
    func tableHeaderView(tableHeaderView: UIView) -> UIView {
        
        let contentView = SPersonalHeadContentView(frame: tableHeaderView.frame)
        contentView.configConstraintes()
        return contentView
    }
}

// MARK: - UITableViewDelegate
extension ADPersonalMainViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerView.layoutHeaderView(scrollView.contentOffset)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("ADPersonalResetIDViewController", sender: nil)
        case 1:
            self.performSegueWithIdentifier("ADPersonalAccountViewController", sender: nil)
        default:
            return
        }
    }
}

// MARK: - UITableViewDataSource
extension ADPersonalMainViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ADPersonalMainCell", forIndexPath: indexPath) as! ADPersonalMainCell
        switch indexPath.row {
        case 0:
            cell.typeImg.image = UIImage(named: "ADPersonal_clean")
            cell.titleLbl.text = "清除设备唯一ID"
        case 1:
            cell.typeImg.image = UIImage(named: "SPersonal_account")
            cell.titleLbl.text = "账号安全"
        default:
            print("")
        }
        return cell
    }
}
