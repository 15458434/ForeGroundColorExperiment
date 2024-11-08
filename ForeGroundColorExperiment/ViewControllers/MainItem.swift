//
//  MainItem.swift
//  ForeGroundColorExperiment
//
//  Created by Mark Cornelisse on 08/11/2024.
//

import UIKit

final class MainItem: NSObject, Identifiable {
    var name: String?
    
    init(name: String? = nil) {
        self.name = name
        super.init()
    }
    
    // MARK: Identifiable
    
    let id: UUID = UUID()
}


