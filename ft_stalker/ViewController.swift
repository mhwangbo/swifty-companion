//
//  ViewController.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/2/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let UID: String = "0a9f99dd9609d91f855558ac6c10fd4ce6918ffcb81091fe7824ad3f29e78c12"
    let SECRET: String = "7e062891f47cefac9f71cd3d0f420a0273005adbe5386446faff9a280b750c9a"
    let URL: String = "https://api.intra.42.fr"
    let AUTH_LINK: String = "/oauth/token"
    let USER_LINK: String = "/v2/users/"
    var TOKEN: String = ""
    var tokenExpire: Double = 0
    var json: JSON?
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getToken()
        logo.image = UIImage(named: "logo.png")
        background.image = UIImage(named: "background.jpg")
        
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoSegue" {
            let infoVC = segue.destination as! PageViewController

            infoVC.json = self.json
        }
    }
    
    @IBOutlet weak var buttonEnable: UIButton!
    
    @IBAction func searchButton(_ sender: UIButton) {
        buttonEnable.isEnabled = false
        let intraLogin = loginInput.text!
        if (intraLogin.isEmpty == true) {
            buttonEnable.isEnabled = true
        } else {
            if (NSDate().timeIntervalSince1970 > tokenExpire) {
                self.getToken()
            }
            let header: HTTPHeaders = ["Authorization": "Bearer \(self.TOKEN)"]
            Alamofire.request(URL + USER_LINK + intraLogin, method: .get, headers: header).responseJSON{
                response in
                switch response.result {
                case .success:
                    print ("Success")
                    self.json = JSON(response.value!)
                    if (self.json?.isEmpty)! {
                        let alert = UIAlertController(title: "Invalid Login", message: "Please try different login", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                        self.buttonEnable.isEnabled = true
                    } else {
                        self.performSegue(withIdentifier: "InfoSegue", sender: self)
                        self.buttonEnable.isEnabled = true
                    }
                case .failure(let error):
                    print(error)
                    _ = UIAlertController(title: "Your Title", message: "Your Message", preferredStyle: UIAlertController.Style.alert)
                    self.buttonEnable.isEnabled = true
                }
            }
        }
    }
    
    func getToken() {
        Alamofire.request(URL + AUTH_LINK, method: .post, parameters: ["grant_type" : "client_credentials", "client_id" : UID, "client_secret" : SECRET]).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Connection Validation Successful")
                self.json = JSON(response.value!)
                self.TOKEN = self.json!["access_token"].string!
                self.tokenExpire = self.json!["created_at"].double! + self.json!["expires_in"].double!
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

