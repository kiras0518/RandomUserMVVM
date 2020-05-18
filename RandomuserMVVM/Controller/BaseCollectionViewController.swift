//
//  BaseCollectionViewController.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/18.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
