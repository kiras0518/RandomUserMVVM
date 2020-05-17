//
//  HomeViewController.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifier)
        
        return collectionView
    }()
    
    lazy var refreshControl:UIRefreshControl = {
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
            
            NetworkManager.shared.fetchCount { (res, err) in
                
                self.data += res?.results ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            // 滾動到最下方最新的 Data
            //self.collectionView.scrollToItem(at: [0, self.data.count - 1], at: .bottom, animated: true)
        }
        
    }
    
    func setupViews() {
        collectionView.backgroundColor = .systemBlue
        collectionView.addSubview(refreshControl)
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getUserData()
    }
    
    var data: [Results] = []
    
    func getUserData() {
        Spinner.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NetworkManager.shared.getRequest { [weak self] (res) in
                switch res {
                case .success(let userResult):
                    
                    self?.data = userResult.results ?? []
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    Spinner.stop()
                case.failure(let error):
                    print("Bad", error)
                }
            }
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { fatalError("UserCell Fail") }
        
        let model = data[indexPath.row]
        
        cell.nameLabel.text = model.email
        
        let url = URL(string: model.picture?.medium ?? "")
        
        cell.userImage.downloadImage(from: url!)
        
        print("indexPath.row", indexPath.row)
        
        return cell
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
