//
//  GenericResultBuilder.swift
//  ForeGroundColorExperiment
//
//  Created by Mark Cornelisse on 08/11/2024.
//

import Foundation

@resultBuilder
struct GenericItemBuilder<Item> {
    static func buildBlock(_ components: Item...) -> [Item] {
        return components
    }
    
    static func buildBlock(_ components: [Item]...) -> [Item] {
        components.flatMap { $0 }
    }
    
    /// Add support for both single and collections of constraints.
    static func buildExpression(_ expression: Item) -> [Item] {
        [expression]
    }
    
    static func buildExpression(_ expression: [Item]) -> [Item] {
        expression
    }
    
    /// Add support for optionals.
    static func buildOptional(_ components: [Item]?) -> [Item] {
        components ?? []
    }
    
    /// Add support for if statements.
    static func buildEither(first components: [Item]) -> [Item] {
        components
    }
    
    static func buildEither(second components: [Item]) -> [Item] {
        components
    }
    
    /// Add support for loops.
    static func buildArray(_ components: [[Item]]) -> [Item] {
        components.flatMap { $0 }
    }
    
    /// Add support for #availability checks.
    static func buildLimitedAvailability(_ components: [Item]) -> [Item] {
        components
    }
}
