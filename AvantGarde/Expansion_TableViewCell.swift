//
//  Expansion_TableViewCell.swift
//  AvantGarde
//
//  Created by Sharad technology on 3/21/17.
//  Copyright © 2017 Sharad technology. All rights reserved.
//

import UIKit

class Expansion_TableViewCell: UITableViewCell {
    @IBOutlet weak var Email_UILabel: UILabel!
    @IBOutlet weak var Specification_UiLabel: UILabel!
    @IBOutlet weak var plus_minus_ImageView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    var heightConstraintSecondView:NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var showsDetails = false {
        didSet {
            heightConstraintSecondView.priority = showsDetails ? 250 : 999
        }
    }
}
