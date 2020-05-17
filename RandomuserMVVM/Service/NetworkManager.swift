//
//  NetworkManager.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

enum VError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your interner connection."
    case invalidData = "the data received from the server was invlaid. Please try again."
    case invalidRequest = "The endpoint request to get venues is invalid."
    case invalidPhotoRequest = "The endpoint request to get photos is invalid"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL = "https://randomuser.me/api/?results="
    
    func getRequest(completed: @escaping (Result<Base, VError>) -> Void) {
        let endpoint = baseURL + "8"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let error = err {
                print(error)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = res as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let venues = try decoder.decode(Base.self, from: data)
                //print(venues)
                completed(.success(venues))
            } catch {
                print(error)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func fetchCount(completion: @escaping (Base?, VError?) -> ()) {
        getRequest { (res) in
            switch res {
            case .success(let result):
                completion(result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
