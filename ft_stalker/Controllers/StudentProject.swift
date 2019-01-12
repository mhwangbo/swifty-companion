//
//  StudentProject.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/11/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentProject: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var band: UIImageView!
    @IBOutlet weak var studentPicture: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var infodata: JSON?
    var project: [projectVO] = []
    
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
        
        let projectClass = Project(for: infodata!)
        project = projectClass.project
        tableView.dataSource = self
    }
    
    func progressBarCalculation(level: Float) {
        let levelFloor = floor(level)
        let percent = (level - levelFloor)
        levelLabel.text = "Level: \(level)%"
        levelProgress.progress = Float(percent)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProjectViewCell.identifier, for: indexPath) as? ProjectViewCell {
            cell.name.text = project[indexPath.row].name
            if project[indexPath.row].pass == false {
                cell.score.textColor = UIColor.red
            } else {
                cell.score.textColor = UIColor.init( red: CGFloat(92/255.0), green: CGFloat(184/255.0), blue: CGFloat(92/255.0), alpha: CGFloat(1.0) )
            }
            cell.score.text = "\(project[indexPath.row].finalMark ?? 0)"
            cell.slug.text = project[indexPath.row].slug
            
            return cell
        }
        return UITableViewCell()
    }
}

