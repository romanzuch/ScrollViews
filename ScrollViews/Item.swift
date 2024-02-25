//
//  Item.swift
//  ScrollViews
//
//  Created by Roman Zuchowski on 25.02.24.
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
