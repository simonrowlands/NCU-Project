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
        
        let input = UsersViewModel.Input(postsButtonTap: getPostsButton.rx.tap, userButtonTap: getUserButton.rx.tap)
        let output = viewModel.transform(input)
        
        output.postsCount.bind { [weak self] count in
            self?.postsCountLabel.text =  "Posts: " + String(count)
        }.disposed(by: disposeBag)
        
        output.commentsCount.bind { [weak self] count in
            self?.commentsCountLabel.text =  "Comments: " + String(count)
        }.disposed(by: disposeBag)
        
        output.userID.bind { [weak self] userID in
            self?.userIDLabel.text = "User ID: " + String(userID)
        }.disposed(by: disposeBag)
        
        output.userPostCount.bind { [weak self] postCount in
            self?.userPostsCountLabel.text = "Post Count: " + String(postCount)
        }.disposed(by: disposeBag)
    }
}
