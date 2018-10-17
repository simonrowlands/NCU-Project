//
//  DogsTableViewController.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 15/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

final class DogsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = DogsViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        tableView.dataSource = nil // Required as dataSource is being replaced
        
        let input = DogsViewModel.Input(filterString: searchBar.text ?? "")
        let output = viewModel.transform(input)
        
        let filteredDogs = Observable.combineLatest(searchBar.rx.text, output.networkRequestResult) { (filterString, dogs) -> [Dog] in
            
            return dogs.filter { dog in
                
                if let filterString = filterString, !filterString.isEmpty {
                    return dog.breed.lowercased().contains(filterString.lowercased())
                }
                return true
            }
        }
        
        filteredDogs.subscribe { [weak self] in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        filteredDogs.bind(to: tableView.rx.items(cellIdentifier: "dogCell", cellType: UITableViewCell.self)) { row, dog, cell in
            cell.textLabel?.text = dog.breed
        }.disposed(by: disposeBag)
    }
}
