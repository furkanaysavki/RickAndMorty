//
//  LaunchViewController.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 20.04.2023.
//

import UIKit

class CustomLaunchScreen: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.modalTransitionStyle = .flipHorizontal
            self.present(mainVC, animated: true)
        }
        
        if defaults.bool(forKey: "First Launch") == true {
            
            welcomeLabel.text = "Hello"
            defaults.set(true, forKey: "First Launch")
        } else {
           
            welcomeLabel.text = "Welcome"
            defaults.set(true, forKey: "First Launch")
        }
    }
}
