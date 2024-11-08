//
//  MainViewController.swift
//  ForeGroundColorExperiment
//
//  Created by Mark Cornelisse on 08/11/2024.
//

import UIKit
import Combine

final class MainViewController: UITableViewController {
    @IBOutlet var model: MainModel!
    
    private var dataSource: UITableViewDiffableDataSource<Int, MainItem>!
    
    private var bag = Set<AnyCancellable>()
    
    // MARK: UITableViewController
    
    // MARK: UIViewController
    
    override func loadView() {
        super.loadView()
        
        let nib = UINib(nibName: MainCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MainCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
            cell.update(label: itemIdentifier.name)
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.model.publisher(for: \.items, options: [.initial, .new])
            .sink(receiveValue: { [weak self] items in
                var snapshot = NSDiffableDataSourceSnapshot<Int, MainItem>()
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([0])
                }
                if snapshot.itemIdentifiers.isEmpty {
                    snapshot.appendItems(items)
                } else {
                    let currentItems = snapshot.itemIdentifiers(inSection: 0)
                    let diff = currentItems.difference(from: items)
                    
                    // Iterate over the diff to apply changes
                    for change in diff {
                        switch change {
                        case .insert(offset: let offset, element: let newItem, associatedWith: _):
                            snapshot.insertItems([newItem], afterItem: currentItems[offset])
                        case .remove(offset: let offset, element: _, associatedWith: _):
                            snapshot.deleteItems([currentItems[offset]])
                        }
                    }
                }
                
                self?.dataSource.apply(snapshot)
            })
            .store(in: &bag)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        bag.removeAll(keepingCapacity: true)
    }
    
    // MARK: UIResponder
    
    // MARK: NSObject
    
}

