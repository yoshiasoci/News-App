//
//  NewsCategoryViewController.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsCategoryViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var newsCategoryViewModel: NewsCategoryViewModelable
    let disposeBag = DisposeBag()
    
    init(viewModel: NewsCategoryViewModelable) {
        self.newsCategoryViewModel = viewModel
        super.init(nibName: "NewsCategory", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = categoryCollectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        self.categoryCollectionView.delegate = self
        
        self.categoryCollectionView.register(UINib(nibName: "NewsCategoryCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryCell")
        
        navigationItem.title = "News Category"
        
        bindData()

    }
    
    //MARK: - Private Method
    private func bindData() {
        
        //CollectionView
        newsCategoryViewModel.categoryCollectionView
            .asObservable()
            .bind(to: self.categoryCollectionView.rx.items(cellIdentifier: "NewsCategoryCell", cellType: NewsCategoryCollectionViewCell.self)) { (row,data,cell) in
                cell.populateCell(categoryImage: data, categoryName: data)
        }.disposed(by: disposeBag)
        
        //Cell Tapped
        self.categoryCollectionView.rx.modelSelected(String.self)
            .subscribe(onNext: { (category) in
                self.newsCategoryViewModel.categoryName.accept(category.lowercased())
                self.newsCategoryViewModel.cellCategoryTapped.onNext(())
        }).disposed(by: disposeBag)
        
    }

}

extension NewsCategoryViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width / 2
        return cellWidth
    }
    
}
