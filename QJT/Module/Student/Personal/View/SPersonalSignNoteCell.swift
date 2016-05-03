//
//  SPersonalSignNoteCell.swift
//  QJT
//
//  Created by YC on 16/5/2.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class SPersonalSignNoteCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var quekeLabel: UILabel!
    @IBOutlet weak var chidaoLabel: UILabel!
    @IBOutlet weak var zaotuiLabel: UILabel!
    @IBOutlet weak var qingjiaLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
