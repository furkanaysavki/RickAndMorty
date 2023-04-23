//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 16.04.2023.
//

import Foundation
// MARK: - Welcome
struct SingleLocationModel: Codable {
    
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
