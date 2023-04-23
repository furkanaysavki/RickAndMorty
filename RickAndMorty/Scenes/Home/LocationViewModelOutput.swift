//
//  HomeViewModelOutput.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation

protocol LocationViewModelOutput : AnyObject {
    func locations(locations : [Locations])
}
protocol CharacterViewModelOutput: AnyObject {
    func characters(characters: [CharactersModel])
}
