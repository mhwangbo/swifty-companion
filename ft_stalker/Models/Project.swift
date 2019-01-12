//
//  Project.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/11/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import Foundation
import SwiftyJSON

class projectVO {
    init () {}
    var name: String?
    var slug: String?
    var finalMark: Int?
    var pass: Bool?
}

class Project {
    
    var project: [projectVO] = []
    
    init (for data: JSON) {
        for each in data["projects_users"] {
            if each.1["status"] == "finished" {
                let tmp = projectVO()
                tmp.name = each.1["project"]["name"].string
                tmp.slug = each.1["project"]["slug"].string
                tmp.finalMark = each.1["final_mark"].int
                tmp.pass = each.1["validated?"].bool
                project.append(tmp)
            }
        }
    }
}
