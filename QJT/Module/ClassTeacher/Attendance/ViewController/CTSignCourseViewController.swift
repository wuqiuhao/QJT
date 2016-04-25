//
//  CTSignCourseViewController.swift
//  QJT
//
//  Created by YC on 16/4/25.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class CTSignCourseViewController: UIViewController {

    var lat: String?
    var long: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let courseView = CourseView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height-64))
        self.view.addSubview(courseView)
        print("\(self.lat!):\(self.long!)")
        // Do any additional setup after loading the view.
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
