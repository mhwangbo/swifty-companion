//
//  Skill.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/11/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Skill {
    var skillsTextArray : [String] = []
    var skillsValuesArray : [Float] = []
    
    init(for data: JSON) {
        for skill in data["cursus_users"][0]["skills"] {
            if let skillVal = skill.1["level"].float {
                if (skillsValuesArray.append(skillVal)) == nil {
                    skillsValuesArray = [skillVal]
                }
                let result = ("\(skill.1["name"])")
                if (skillsTextArray.append(result)) == nil {
                    skillsTextArray = [result]
                }
            }
        }
    }
}
