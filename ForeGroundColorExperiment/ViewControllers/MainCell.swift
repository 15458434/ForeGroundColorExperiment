//
//  MainCell.swift
//  ForeGroundColorExperiment
//
//  Created by Mark Cornelisse on 08/11/2024.
//

import UIKit

final class MainCell: UITableViewCell {
    static let identifier: String = "MainCell"
    
    @IBOutlet private var label: UILabel!
    
    func update(label: String?) {
        let attr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label]
        let attributedLabel: NSAttributedString = NSAttributedString(string: label ?? "", attributes: attr)
        self.label.attributedText = attributedLabel
    }
    
    // MARK: UITableViewCell
    
    // MARK: NSCoding
    
    // MARK: UIView
    
    // MARK: UIResponder
    
    // MARK: NSObject
}

