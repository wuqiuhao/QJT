//
//  LoginMeetViewController.swift
//  QJT
//
//  Created by LZQ on 16/3/31.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class LoginMeetViewController: LoginStepViewController {

    @IBOutlet private weak var yellowTriangle: UIImageView!
    @IBOutlet private weak var greenTriangle: UIImageView!
    @IBOutlet private weak var purpleTriangle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animate(yellowTriangle, offset: 3, duration: 3)
        animate(greenTriangle, offset: 7, duration: 2)
        animate(purpleTriangle, offset: 5, duration: 2)
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
