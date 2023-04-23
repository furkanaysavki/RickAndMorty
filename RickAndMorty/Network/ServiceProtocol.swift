//
//  ServiceProtocol.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation

protocol GetLocations {
    func getLocations<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void) 
}
protocol GetSingleLocation {
    func getSingleLocation<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void)
}
protocol GetCharacters {
    func getCharacters<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void)
}
