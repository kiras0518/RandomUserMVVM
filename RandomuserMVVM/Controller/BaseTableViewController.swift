//
//  BaseTableViewController.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/18.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
