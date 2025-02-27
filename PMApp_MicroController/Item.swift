//
//  Item.swift
//  PMApp_MicroController
//
//  Created by David García on 26/02/25.
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
