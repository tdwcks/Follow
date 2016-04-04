//
//  CustomTextField.swift
//  Follow
//
//  Created by Tom Wicks on 04/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    
    var change: Bool = false {
        didSet {
            if change {
                // Add some customization
                textColor = UIColor.yellowColor()
                backgroundColor = UIColor.blueColor()
            } else {
                // Change the colors back to original
                textColor = UIColor.blackColor()
                backgroundColor = UIColor.whiteColor()
            }
        }
    }
}