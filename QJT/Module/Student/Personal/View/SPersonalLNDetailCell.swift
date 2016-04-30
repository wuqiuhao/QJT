//
//  SPersonalLNDetailCell.swift
//  QJT
//
//  Created by LZQ on 16/4/30.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalLNDetailCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var phoneImg: UIImageView!
    
    weak var fatherVC: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCall()
        
    }

}

extension SPersonalLNDetailCell {
    
    func setupCall() {
        phoneImg.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(SPersonalLNDetailCell.phoneImgClicked))
        phoneImg.addGestureRecognizer(tap)
    }
    
    func phoneImgClicked() {
        
        let alertVC = UIAlertController(title: "15381144627", message: "确认要拨打该电话吗？", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            let phoneUrl = NSURL(string: "tel://15381144627")
            let app = UIApplication.sharedApplication()
            app.openURL(phoneUrl!)
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertVC.addAction(confirmAction)
        alertVC.addAction(cancelAction)
        fatherVC?.presentViewController(alertVC, animated: true, completion: nil)
    }
    
}
