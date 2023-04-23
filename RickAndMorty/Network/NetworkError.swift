//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Furkan Ayşavkı on 15.04.2023.
//

import Foundation

enum NetworkError: Error {
    
    case networkFailed
    case parsingFailed
    
    var errorDescription: String? {
        
        switch self {
        case .networkFailed:
            return "Network Failed"
        case .parsingFailed:
            return "Parsing Failed "
       
        }
    }
    
}
