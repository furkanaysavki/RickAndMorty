//
//  LocationsCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import UIKit

class LocationsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    func viewCell(model : Locations ) {
        locationLabel.text = model.name
        
}
    func configure(select: Bool) {
        if select {
            self.backgroundColor = .lightGray
        } else {
            self.backgroundColor = .clear
        }
    }
}

