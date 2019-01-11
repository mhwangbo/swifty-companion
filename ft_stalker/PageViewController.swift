//
//  PageViewController.swift
//  ft_stalker
//
//  Created by Mi Hwangbo on 1/4/19.
//  Copyright © 2019 Mi Hwangbo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
   lazy var pages: Array = [self.loadVC("StudentInfo"), self.loadVC("StudentSkill"), self.loadVC("StudentProject")]
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let info = pages[0] as! StudentInfo
        info.infodata = json
        
        let skill = pages[1] as! StudentSkill
        skill.infodata = json
        
        let project = pages[2] as! StudentProject
        project.infodata = json
        
        setViewControllers([pages[0]], direction: .reverse, animated: false, completion: nil)
    }
    
    func loadVC(_ storyboardId: String) -> UIViewController {
        return (self.storyboard?.instantiateViewController(withIdentifier: storyboardId))!
    }
    

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0          else { return pages.last }
        guard pages.count > previousIndex else { return nil        }
        return pages[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil         }
        return pages[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
