//
//  InfoTableViewCell.swift
//  Login
//
//  Created by ALgy Aly on 9/7/19.
//  Copyright © 2019 ALgy Aly. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNr: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblEmail.textColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
