//
//  UserListCell.swift
//  SignUp
//
//  Created by AshutoshD on 20/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit

class UserListCell: UITableViewCell {
    
    
    
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblMob : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var lblDescription : UILabel!
    @IBOutlet var viewMain : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    func animate() {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.contentView.layoutIfNeeded()
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
