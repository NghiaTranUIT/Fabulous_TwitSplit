//
//  XIBInitialization.swift
//  TwitterApp
//
//  Created by Nghia Tran on 9/30/17.
//  Copyright © 2017 Nghia Tran. All rights reserved.
//

import Foundation
import UIKit

protocol XIBInitialization {

    associatedtype XIBType
}

extension XIBInitialization where XIBType: UIViewController {

    static func xib() -> XIBType {
        return XIBType(nibName: XIBType.identifier, bundle: nil)
    }
}

extension XIBInitialization where XIBType: UIView {

    static func xib() -> XIBType {
        let xib = UINib(nibName: XIBType.identifier, bundle: nil)
        return xib.instantiate(withOwner: self, options: nil).first as! XIBType
    }
}
