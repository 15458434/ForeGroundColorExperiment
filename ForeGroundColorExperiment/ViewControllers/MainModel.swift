//
//  MainModel.swift
//  ForeGroundColorExperiment
//
//  Created by Mark Cornelisse on 08/11/2024.
//

import UIKit

final class MainModel: NSObject {
    @objc dynamic private(set) var items: [MainItem]
    
    override init() {
        @GenericItemBuilder<MainItem> var items: [MainItem] {
            MainItem(name: "Mark")
            MainItem(name: "John")
            MainItem(name: "Sally")
            MainItem(name: "Joe")
            MainItem(name: "Jane")
            MainItem(name: "Tom")
            MainItem(name: "Sue")
            MainItem(name: "Jim")
            MainItem(name: "Jill")
            MainItem(name: "Bob")
            MainItem(name: "Alice")
        }
        self.items = items
        super.init()
    }
}
