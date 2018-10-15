//
//  WrapContentConstraint+Constants.swift
//  PetSpotCoreUI
//
//  Created by Mario Plaza on 19/9/18.
//  Copyright © 2018 Machipla. All rights reserved.
//

import Foundation
import UIKit

extension WrapContentConstraint{
    static let hiddenViewObservingPath = "hidden"
 
    enum DefaultLayoutPriorities{
        static let disabled = UILayoutPriority(rawValue: 1)
        static let enabled = UILayoutPriority(rawValue: 999)
    }
}
