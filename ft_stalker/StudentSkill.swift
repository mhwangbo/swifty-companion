//
//  StudentSkill.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/4/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentSkill: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var studentPicture: UIImageView!
    var infodata: JSON?
    var skillsTextArray : [String] = []
    var skillsValuesArray : [Float] = []
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var band: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = infodata?["image_url"].string {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            studentPicture.layer.cornerRadius = 60.0
            studentPicture.layer.masksToBounds = true
            studentPicture.image = UIImage(data: data!)
        }
        band.image = UIImage(named: "background.jpg")
        band.layer.masksToBounds = true
        if let levelData = infodata?["cursus_users"][0]["level"].float {
            let fullLevel = levelData
            progressBarCalculation(level: fullLevel)
        }
        if let nameData = infodata?["displayname"].string {
            studentName.text = nameData
        } else {
            studentName.text = "unavailable"
        }
        
        let skillCalc = Skill(for: infodata!)
        skillsTextArray = skillCalc.skillsTextArray
        skillsValuesArray = skillCalc.skillsValuesArray
        tableView.dataSource = self

    }
    
    func progressBarCalculation(level: Float) {
        let levelFloor = floor(level)
        let percent = (level - levelFloor)
        levelLabel.text = "Level: \(level)%"
        levelProgress.progress = Float(percent)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skillsTextArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SkillViewCell.identifier, for: indexPath) as? SkillViewCell {
                cell.skillName.text = skillsTextArray[indexPath.row]
                cell.skillLevel.text = "\(skillsValuesArray[indexPath.row])"
                cell.skillProgress.progress = skillsValuesArray[indexPath.row] / 21
            return cell
        }
        return UITableViewCell()
    }

}

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
