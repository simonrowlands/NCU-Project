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

class DogsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let viewModel = DogsViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dogsJSON = viewModel.transform(DogsViewModel.Input(filterString: ""))
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = DogsViewModel.Input(filterString: searchBar.rx.text.asObservable())
        
        let output = viewModel.transform(input)
        
        output.networkRequestResult
            .subscribe(onNext: { json in
                // import data into tableView
            })
            .disposed(by: disposeBag)
        
        
        // Bind searchBar.rx.text to tableView data
        
        tableView.dataSource = nil // Required as dataSource is being replaced
        
        // TODO: Bind tableView to data
        // TODO: Bind searchBar to data
    }
}
