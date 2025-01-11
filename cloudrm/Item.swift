//
//  Item.swift
//  cloudrm
//
//  Created by Jean Laura on 11/01/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
