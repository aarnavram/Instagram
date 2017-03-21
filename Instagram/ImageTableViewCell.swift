//
//  ImageTableViewCell.swift
//  Instagram
//
//  Created by Aarnav Ram on 18/03/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var mainImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    

    
    var instagramPost: PFObject! {
        didSet {
            self.usernameLabel.text = PFUser.current() as? String
            self.captionLabel.textColor = UIColor.white
            self.captionLabel.text = instagramPost["caption"] as? String
            self.usernameLabel.textColor = UIColor.white
            self.mainImageView.file = instagramPost["media"] as? PFFile
            self.mainImageView.clipsToBounds = true
            self.mainImageView.loadInBackground()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
