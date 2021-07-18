/**
 * Niagara
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit
import UIKitHelpers

struct WaterfallItem {
    
    let index: Int
    
    let size = CGSize(width: 140, height: 50 + .random(in: 0...100))
    
    let color = UIColor.random()
}

extension WaterfallItem: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}
