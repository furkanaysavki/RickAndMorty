//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation
import UIKit

class HomeViewModel {
    
    weak var locationOutput: LocationViewModelOutput?
    weak var charaterOutput: CharacterViewModelOutput?
    lazy var network: GetLocations = Service()
    lazy var singleLocationNetwork: GetSingleLocation = Service()
    lazy var characterNetwork: GetCharacters = Service()
    var idArray = [Int]()
    
     func getLocations() {
         network.getLocations(LocationsModel.self, url: "\(Constants.baseURL)location?page=1") { [weak self]  result in
            switch result {
            case .success(let response):
                self?.locationOutput?.locations(locations: response.results)
            case .failure(_):
                print(NetworkError.parsingFailed)
            }
        }
    }
    func getSingleLocationAndCharacters(with id: Int) {
        let group = DispatchGroup()
        group.enter()
        let locationUrl = "\(Constants.baseURL)location/\(id)"
        singleLocationNetwork.getSingleLocation(SingleLocationModel.self, url: locationUrl) { [weak self] result in
           switch result {
           case .success(let response):
               for url in response.residents {
                  let seperated = url.components(separatedBy: "/")
                   self!.idArray.append(Int(seperated[5])!)
                  }
           case .failure(_):
               print(NetworkError.parsingFailed)
               }
            group.leave()
       }
       group.notify(queue: .main) {
            let characterUrl = "\(Constants.baseURL)character/\(self.idArray.debugDescription.replacingOccurrences(of: ", ", with: ","))"
           self.characterNetwork.getCharacters(charactersModel.self, url: characterUrl) { [weak self] result in
                switch result {
                case .success(let response):
                    self!.charaterOutput?.characters(characters: response)
                case .failure(_):
                    print(NetworkError.parsingFailed)
                }
               self!.idArray.removeAll()
            }
        }
   }
    }
