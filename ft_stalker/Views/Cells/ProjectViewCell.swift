//
//  ProjectViewCell.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/11/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit

class ProjectViewCell: UITableViewCell {

    @IBOutlet weak var slug: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        print(ProjectsTableViewCell.identifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
