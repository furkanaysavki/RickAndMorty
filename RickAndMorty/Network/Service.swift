//
//  Service.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation
import Alamofire

final class Service: GetLocations, GetSingleLocation, GetCharacters  {
    
    func getLocations<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void) {
        AF.request(url, method: .get).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                completion(.failure(NetworkError.parsingFailed))
            }
        }
    }
    func getSingleLocation<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                completion(.failure(NetworkError.parsingFailed))
            }
        }
    }
    func getCharacters<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                completion(.failure(NetworkError.parsingFailed))
            }
        }
    }
}

