//
//  HomeViewController.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

enum PageStuts {
    case LoadingMore
    case NotLoadingMore
}

class HomeViewController: BaseCollectionViewController, NetworkServiceDelegate {
    
    func didComplete(result: String) {
        print("I got \(result) from the server!")
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.backgroundColor = .red
        rc.attributedTitle = NSAttributedString(string: "Pull to refresh")
        rc.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return rc
    }()
    
    @objc func loadData() {
        print("loadDataloadData")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.refreshControl.endRefreshing()
            
            NetworkManager.shared.fetchCount { (result) in
                
                switch result {
                case .success(let model):
                    self.data += model?.results ?? []
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
            // 滾動到最下方最新的 Data
            //            self.collectionView.scrollToItem(at: [0, self.data.count - 1],
            //                                             at: .bottom,
            //                                             animated: true)
        }
        
    }
    
    func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
        collectionView.register(LodingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LodingFooter.identifier)
        collectionView.backgroundColor = .systemBlue
        collectionView.addSubview(refreshControl)
        view.addSubview(collectionView)
    }
    
    func update(_ model: [Results]) {
        self.data += model
    }
    
    var data: [Results] = []
    var viewModel = BaseViewModel()
    var pagestatus: PageStuts = .NotLoadingMore
    
    var isDonePagination = false
    var networkDelegate = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        //        networkDelegate.delegate = self
        //        networkDelegate.fetchDataFromUrl(url: "https://randomuser.me/api/?results=8")
        
        viewModel.fetch()
        
        viewModel.addObserve { (model) in
            self.update(model ?? [])
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LodingFooter.identifier, for: indexPath)
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = isDonePagination ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("data.count", data.count)
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { fatalError("UserCell Fail") }
        
        let model = data[indexPath.row]
        
        cell.config(model: model)
        
        print("indexPath.row", indexPath.row)
        
        if indexPath.row == data.count - 1 {
            print("fetch more data")
            
            self.pagestatus = .LoadingMore
            
            switch pagestatus {
            case .LoadingMore:
                
                NetworkManager.shared.fetchCount { (result) in
                    
                    switch result {
                    case .success(let models):
                        
                        print("LoadingMore")
                        
                        if models?.results?.count == 0 {
                            print("==0==")
                            self.isDonePagination = true
                        }
                        
                        sleep(2)
                        
                        self.data += models?.results ?? []
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                        self.pagestatus = .NotLoadingMore
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                
            default:
                ()
                print("NotLoadingMore")
            }
        }
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
