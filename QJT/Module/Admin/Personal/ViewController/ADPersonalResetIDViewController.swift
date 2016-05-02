//
//  ADPersonalResetIDViewController.swift
//  QJT
//
//  Created by LZQ on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class ADPersonalResetIDViewController: UIViewController {

    
    @IBOutlet weak var numTfd: UITextField!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension ADPersonalResetIDViewController {
    func configUI() {
        navigationItem.title = "设备ID重置"
    }
    
    func setupButton() {
        resetBtn.layer.cornerRadius = 5
        resetBtn.layer.masksToBounds = true
        resetBtn.addTarget(self, action: #selector(ADPersonalResetIDViewController.resetBtnClicked), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func resetBtnClicked() {
        self.pleaseWait()
        NetWorkManager.httpRequest(Methods.login_removeStudentDeviceID, params: ["studentID":numTfd.text!], modelType: EmptyModel(), listType: nil, completed: { (responseData) in
            self.clearAllNotice()
            self.successNotice("重置成功")
            self.navigationController?.popViewControllerAnimated(true)
            }) { [weak self](errorMsg) in
                self?.clearAllNotice()
                self?.errorNotice(errorMsg!)
        }
    }
}