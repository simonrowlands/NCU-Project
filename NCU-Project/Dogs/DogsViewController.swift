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
    
    private let viewModel = DogsViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        tableView.dataSource = nil // Required as dataSource is being replaced
        
        let input = DogsViewModel.Input(query: searchBar.rx.text.orEmpty.asObservable())
        let output = viewModel.transform(input)
        
        output.networkRequestResult
            .bind(to: tableView.rx.items(cellIdentifier: "dogCell", cellType: UITableViewCell.self)) { row, dog, cell in
                cell.textLabel?.text = dog.breed
            }.disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .bind { [weak self] in
                self?.searchBar.resignFirstResponder()
            }.disposed(by: disposeBag)
    }
}
