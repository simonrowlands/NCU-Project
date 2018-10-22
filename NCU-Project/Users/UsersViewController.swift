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
        
        getPostsButton.rx.tap
            .bind { [weak self] in
                
                guard let strongSelf = self else {
                    return
                }
                
                let activityIndicator = ActivityIndicator()
                
                Observable.zip(UsersNetworkingAPI.getPosts(), UsersNetworkingAPI.getComments())
                    .trackActivity(activityIndicator)
                    .map { return ($0, $1) }
                    .observeOn(MainScheduler.instance)
                    .bind { [weak strongSelf] response in
                        
                        guard let strongerSelf = strongSelf else {
                            return
                        }
                        
                        strongerSelf.postsCountLabel.text = "Posts: %@" + String(response.0.count)
                        strongerSelf.commentsCountLabel.text = "Comments: %@" + String(response.1.count)
                        
                    }.disposed(by: strongSelf.disposeBag)
                
            }.disposed(by: disposeBag)
    }
}
