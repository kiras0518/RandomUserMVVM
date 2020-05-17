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

class Spinner {
    
    static var spinner: UIActivityIndicatorView?
    static var style: UIActivityIndicatorView.Style = .whiteLarge
    static var baseBackColor = UIColor.systemGray
    static var baseColor = UIColor.systemBlue // 轉圈顏色
    
    static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        if spinner == nil {
            let frame = UIScreen.main.bounds
            //print(ScreenConfigs.widthScreenScaleFactor, ScreenConfigs.heightScreenScaleFactor)
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = backColor
            spinner?.style = style
            spinner?.color = baseColor
            window?.addSubview(spinner!)
            spinner?.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 100, height: 100))
            spinner?.centerInSuperview()
            spinner?.layer.backgroundColor = UIColor(red: 179 / 255.0, green: 182 / 255.0, blue: 202 / 255.0, alpha: 0.4).cgColor
            spinner?.layer.cornerRadius = 16
            spinner?.startAnimating()
        }
    }
    
    static func stop() {
        if spinner != nil {
            DispatchQueue.main.async {
              spinner?.stopAnimating()
              spinner?.removeFromSuperview()
              spinner = nil
            }
        }
    }
    
    static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
    
}

