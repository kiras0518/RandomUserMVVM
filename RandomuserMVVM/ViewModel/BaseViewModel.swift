//
//  BaseViewModel.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/18.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

protocol ViewModelable {
    associatedtype Model
    func addObserve(completion: @escaping (Model?) -> Void)
    func removeObserve()
}

class BaseViewModel {
    
    let service: NetworkManager
    var completion: (([Results]?) -> Void)?
    var onErrorHandling: ((VError?) -> Void)?
    
    var model: [Results]? {
        didSet {
            completion?(model)
        }
    }
    
    init(service: NetworkManager = NetworkManager.shared) {
        self.service = service
    }
    
    func fetch() {
        Spinner.start()
        service.getRequest { (result) in
            switch result {
            case .success(let model):
                self.model = model.results
                Spinner.stop()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension BaseViewModel: ViewModelable {
    typealias Model = [Results]
    
    func addObserve(completion: @escaping ([Results]?) -> Void) {
        self.completion = completion
    }
    
    func removeObserve() {
        self.completion = nil
    }
}
