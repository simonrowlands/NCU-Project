//
//  UsersViewController.swift
//  NCU-Project
//
//  Created by Simon Rowlands on 19/10/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import RxSwift


class UsersViewController: UIViewController {
    
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userPostsCountLabel: UILabel!
    
    @IBOutlet weak var getPostsButton: UIButton!
    @IBOutlet weak var getUserButton: UIButton!
    
    private let viewModel = UsersViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        let input = UsersViewModel.Input(postsButtonTap: getPostsButton.rx.tap.asObservable(), userButtonTap: getUserButton.rx.tap.asObservable())
        let output = viewModel.transform(input)
        
        output.postsCount.bind(to: postsCountLabel.rx.text).disposed(by: disposeBag)
        output.commentsCount.bind(to: commentsCountLabel.rx.text).disposed(by: disposeBag)
        
        output.userID.bind(to: userIDLabel.rx.text).disposed(by: disposeBag)
        output.userPostCount.bind(to: userPostsCountLabel.rx.text).disposed(by: disposeBag)
        
        output.isLoading
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
}
