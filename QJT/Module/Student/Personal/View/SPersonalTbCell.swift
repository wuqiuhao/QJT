//
//  SPersonalTbCell.swift
//  QJT
//
//  Created by LZQ on 16/4/26.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalTbCell: UITableViewCell {

     @IBOutlet weak var partTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - UITableViewDelegate
extension SPersonalTbCell: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension SPersonalTbCell: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SPersonalTbCell", forIndexPath: indexPath) as! SPersonMainCell
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