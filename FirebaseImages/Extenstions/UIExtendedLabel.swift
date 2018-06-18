//
//  UIExtendedLabel.swift
//  FirebaseImages
//
//  Created by Alanda Syla on 6/17/18.
//  Copyright © 2018 Alanda Syla. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UIExtendedLabel: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
