//
//  LoginMatchViewController.swift
//  QJT
//
//  Created by LZQ on 16/3/31.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LoginMatchViewController: LoginStepViewController {

    @IBOutlet private weak var camera: UIImageView!
    @IBOutlet private weak var pen: UIImageView!
    @IBOutlet private weak var book: UIImageView!
    @IBOutlet private weak var controller: UIImageView!
    @IBOutlet private weak var keyboard: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animate(camera, offset: 10, duration: 4)
        animate(pen, offset: 5, duration: 5)
        animate(book, offset: 10, duration: 3)
        animate(controller, offset: 15, duration: 2)
        animate(keyboard, offset: 20, duration: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
