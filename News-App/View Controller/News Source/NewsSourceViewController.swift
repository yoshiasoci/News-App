//
//  NewsSourceViewController.swift
//  News-App
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class NewsSourceViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var sourceCollectionView: UICollectionView!
    
    var newsSourceViewModel: NewsSourceViewModelable
    let disposeBag = DisposeBag()
    
    let loading = SVProgressHUD.self
    
    init(viewModel: NewsSourceViewModelable) {
        self.newsSourceViewModel = viewModel
        super.init(nibName: "NewsSource", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.show()
        
        if let layout = sourceCollectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        self.sourceCollectionView.delegate = self
        
        self.sourceCollectionView.register(UINib(nibName: "NewsSourceCell", bundle: nil), forCellWithReuseIdentifier: "NewsSourceCell")
        
        navigationItem.title = "News Source"
        
        bindData()
        
    }
    
    //MARK: - Private Method
    
    private func bindData() {
        //Need Loading
        newsSourceViewModel.isLoading
            .subscribe{ [weak self] isLoading in
                guard let self = self else { return }
                if isLoading.element ?? false {
                    self.loading.show()
                } else {
                    self.loading.dismiss()
                }
        }.disposed(by: disposeBag)
        
        //CollectionView
        newsSourceViewModel.sourceCollectionView
            .asObservable()
            .bind(to: self.sourceCollectionView.rx.items(cellIdentifier: "NewsSourceCell", cellType: NewsSourceCollectionViewCell.self)) { (row,data,cell) in
                cell.populateCell(sourceName: data?.name, sourceDescription: data?.description, sourceUrl: data?.url)
        }.disposed(by: disposeBag)
        
        //Cell Tapped
        self.sourceCollectionView.rx.modelSelected(Source.self)
            .subscribe(onNext: { (sourceID) in
                self.newsSourceViewModel.sourceID.accept(sourceID.id)
                self.newsSourceViewModel.cellSourceTapped.onNext(())
        }).disposed(by: disposeBag)
    }

}

extension NewsSourceViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width / 2
        return cellWidth
    }
    
}


