//
//  LocationsModel.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation

// MARK: - Welcome
struct LocationsModel: Codable {
    let info: Info
    let results: [Locations]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String

}

// MARK: - Result
struct Locations: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

