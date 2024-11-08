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
                guard let self = self else { return }
                
                var snapshot = self.dataSource.snapshot()
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([0])
                }
                
                let difference = items.difference(from: snapshot.itemIdentifiers)
                for change in difference {
                    switch change {
                    case .insert(let offset, let element, _):
                        if offset == snapshot.itemIdentifiers.count {
                            snapshot.appendItems([element], toSection: 0)
                        } else if offset > 0, offset < snapshot.itemIdentifiers.count {
                            let beforeItem = snapshot.itemIdentifiers[offset]
                            snapshot.insertItems([element], beforeItem: beforeItem)
                        } else {
                            snapshot.insertItems([element], beforeItem: snapshot.itemIdentifiers.first!)
                        }
                    case .remove(_, let element, _):
                        snapshot.deleteItems([element])
                    }
                }
                
                self.dataSource.apply(snapshot, animatingDifferences: true)
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

