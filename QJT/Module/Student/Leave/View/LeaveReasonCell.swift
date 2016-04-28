//
//  LeaveReasonCell.swift
//  QJT
//
//  Created by LZQ on 16/4/27.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LeaveReasonCell: UITableViewCell {

    
    @IBOutlet weak var reasonTextView: UITextView!
    weak var parentVC: UIViewController?
    
    func initCellData(contentText:String) {
        
        self.reasonTextView.text = contentText
    }
    
    func completeBtnClicked() {
        reasonTextView.resignFirstResponder()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //reasonTextView.becomeFirstResponder()
        reasonTextView.layer.borderColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1).CGColor
        reasonTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 40))
        toolBar.barTintColor = UIColor.whiteColor()
        toolBar.layer.borderWidth = 0
        let completeBtn = UIBarButtonItem(title: "完成", style: .Plain, target: self, action: #selector(LeaveReasonCell.completeBtnClicked))
        let fixedButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.items = [fixedButton,completeBtn]
        reasonTextView.inputAccessoryView = toolBar
        reasonTextView.delegate = self
    }
}

extension LeaveReasonCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        let parent = parentVC as! LeaveReasonViewController
        parent.textViewContent = textView.text
        parent.contentHeight = textView.contentSize.height + 55
        parent.tableView.beginUpdates()
        parent.tableView.endUpdates()
    }
}