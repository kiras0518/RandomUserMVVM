//
//  LodingHeader.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class LodingHeader: UICollectionReusableView {
    
    static let identifier = "LodingHeader"
    
    override var reuseIdentifier: String? {
        return LodingHeader.identifier
    }
    
    lazy var activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var label: UILabel = {
        let ib = UILabel()
        ib.text = "Loading more...."
        ib.font = .systemFont(ofSize: 16)
        ib.textAlignment = .center
        return ib
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [activity, label])
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
