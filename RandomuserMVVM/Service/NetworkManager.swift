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
    
    func fetchCount(completion: @escaping (Result<Base?, VError>) -> Void) {
        let url = baseURL + "4"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func getRequest(completion: @escaping (Result<Base?, VError>) -> Void) {
        let url = baseURL + "8"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T?, VError>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    //    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, VError?) -> Void) {
    //
    //        guard let url = URL(string: urlString) else { return }
    //
    //        let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
    //            if let err = err {
    //                print("Failed to fetch apps:", err)
    //                completion(nil, VError.unableToComplete)
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(nil, VError.invalidData)
    //                return
    //            }
    //
    //            do {
    //                let object = try JSONDecoder().decode(T.self, from: data)
    //                completion(object, nil)
    //            } catch {
    //                completion(nil, VError.invalidData)
    //            }
    //
    //        }
    //        task.resume()
    //    }
}
