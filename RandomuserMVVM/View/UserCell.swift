//
//  UserCell.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    static let identifier = "UserCell"
    
    override var reuseIdentifier: String? {
        return UserCell.identifier
    }
    
    let nameLabel: UILabel = {
        let ib = UILabel()
        ib.text = "Ting"
        ib.textAlignment = .center
        ib.font = .boldSystemFont(ofSize: 20)
        ib.backgroundColor = .green
        return ib
    }()
    
    let userImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    func config(model: Results) {
        nameLabel.text = model.email
        let url = URL(string: model.picture?.medium ?? "")
        userImage.downloadImage(from: url!)
    }
    
    fileprivate func setupViews() {

        let stackView = UIStackView(arrangedSubviews: [userImage, nameLabel])
        stackView.spacing = 5
        stackView.alignment = .center
   
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImage.image = nil
    }
}
