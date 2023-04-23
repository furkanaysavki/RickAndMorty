//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 17.04.2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    var episodeArray = [String]()
    var characterDetails: CharactersModel?
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var specyLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        detailView()
        configureNavigationController()
        
    }
    func configureNavigationController() {
        self.title = characterDetails?.name
        navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "AvenirNext-Bold", size: 25)!
        ]
    }
    
    func detailView(){
        guard let url = URL(string: characterDetails?.image ?? "") else {
            return
        }
        detailImage.sd_setImage(with: url)
        statusLabel.text = "\(characterDetails!.status)"
        specyLabel.text = "\(characterDetails!.species)"
        genderLabel.text = "\(characterDetails!.gender)"
        originLabel.text = "\(characterDetails!.origin.name)"
        locationLabel.text = "\(characterDetails!.location.name)"
        createdLabel.text = "\(characterDetails!.created)"
        for episode in characterDetails!.episode {
            let seperated = episode.components(separatedBy: "/")
            episodeArray.append((seperated[5]))
            episodesLabel.text = episodeArray.joined(separator: ",")
        }
    }
}
