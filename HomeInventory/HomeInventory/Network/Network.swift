//
//  Network.swift
//  HomeInventory
//
//  Created by Brody Sears on 4/26/22.
//

import Foundation
import UIKit.UIImage
import UIKit

class Network {
    static let shared = Network()
    var cache = NSCache<NSString, UIImage>()
}
