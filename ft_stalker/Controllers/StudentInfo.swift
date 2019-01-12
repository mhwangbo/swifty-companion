//
//  StudentInfo.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/2/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StudentInfo: UIViewController {
    
    var infodata: JSON?
    var name = ""
    
    @IBOutlet weak var studentPicture: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var band: UIImageView!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var walletPoint: UILabel!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var cursus: UILabel!
    @IBOutlet weak var grade: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let image = infodata?["image_url"].string {
            let url = URL(string: image)
            let data = try? Data(contentsOf: url!)
            studentPicture.layer.cornerRadius = studentPicture.frame.height / 2
            studentPicture.layer.masksToBounds = true
            studentPicture.image = UIImage(data: data!)
        }
        band.image = UIImage(named: "background.jpg")
        band.layer.masksToBounds = true
        if let nameData = infodata?["displayname"].string {
            studentName.text = nameData
        } else {
            studentName.text = "unavailable"
        }
        if let phoneData = infodata?["phone"].string {
            phoneNumber.text = phoneData
        } else {
            phoneNumber.text = "unavailable"
        }
        if let emailData = infodata?["email"].string {
        email.text = emailData
        } else {
            email.text = "unavailable"
        }
        if let locationData = infodata?["location"].string {
            location.text = locationData
        } else {
            location.text = "unavailable"
        }
        if let loginData = infodata?["login"].string {
            loginName.text = loginData
        } else {
            loginName.text = "unavailable"
        }
        if let levelData = infodata?["cursus_users"][0]["level"].float {
            let fullLevel = levelData
            progressBarCalculation(level: fullLevel)
        }
        if let wallet = infodata?["wallet"].int {
            walletPoint.text = "\(wallet )"
        }
        if let corr = infodata?["correction_point"].int {
            correction.text = "\(corr )"
        }
        if let cursusData = infodata?["cursus_users"][0]["cursus"]["name"].string {
            cursus.text = cursusData
        } else {
            cursus.text = "unavailable"
        }
        if let gradeData = infodata?["cursus_users"][0]["grade"].string {
            grade.text = gradeData
        } else {
            grade.text = "unavailable"
        }
    }

    func progressBarCalculation(level: Float) {
        let levelFloor = floor(level)
        let percent = (level - levelFloor)
        levelLabel.text = "Level: \(level)%"
        levelProgress.setProgress(Float(percent), animated: true)
        levelProgress.transform = levelProgress.transform.scaledBy(x: 1, y: 8)
    }
}
