//
//  SkillViewCell.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/10/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit

class SkillViewCell: UITableViewCell {

    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var skillProgress: UIProgressView!
    @IBOutlet weak var skillLevel: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        skillProgress.transform = skillProgress.transform.scaledBy(x: 1, y: 3)
        skillProgress.layer.cornerRadius = 5
        skillProgress.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
