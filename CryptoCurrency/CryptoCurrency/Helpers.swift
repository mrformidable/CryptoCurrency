//
//  Helpers.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    enum ObjectKind {
        case nib
        case `class`
    }
    
    func register(_ kind: ObjectKind, type: UITableViewCell.Type) {
        let className = String(describing: type)
        switch kind {
        case .class:
            register(type, forCellReuseIdentifier: className)
        case .nib:
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as? T
    }
    
}

extension UIView {
    @discardableResult
    class func fromNib<T: UIView>() -> T {
        let className = String(describing: T.self)
        return Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as! T
    }
}
