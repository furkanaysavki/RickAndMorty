//
//  CharactersCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import UIKit
import SDWebImage

class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func viewCell(model : CharactersModel ) {
        guard let url = URL(string: model.image) else {
            return
        }
        characterImage.sd_setImage(with: url)
        characterName.text = model.name
        
        if model.gender == "Male" {
            genderImage.image = UIImage(named: "male")
        } else if model.gender == "Female" {
            genderImage.image = UIImage(named: "female")
        } else if model.gender == "unknown" {
            genderImage.image = UIImage(named: "questionMark")
        }
    }
}

