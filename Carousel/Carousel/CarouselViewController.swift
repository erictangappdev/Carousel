//
//  CarouselViewController.swift
//  Carousel
//
//  Created by 唐紹桓 on 2021/9/24.
//

import UIKit

final class CarouselViewController: UIViewController {
    
    let data: [UIImage] = [.add, .actions, .remove ,.strokedCheckmark]
    
    lazy var collectionView: UICollectionView = .make(owner: self)
    
    lazy var pageControl: UIPageControl = .make(numberOfPages: data.count)
    
    lazy var automaticCarouselService = AutomaticCarouselService(collectionView: collectionView,
                                                                 currentIndex: pageControl.currentPage,
                                                                 dataCount: data.count)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        
        setPageControlLayout()
        
        // 開始輪播
        automaticCarouselService.startCarousel()
    }
}

extension CarouselViewController {

    // 設置 CollectionView
    private func setCollectionView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        
        let reuseId = String(describing: CarouselCollectionViewCell.self)
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: reuseId)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.backgroundColor = .white

        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        
        flowLayout.itemSize = view.bounds.size
        flowLayout.sectionInset = UIEdgeInsets.zero
        
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = .zero
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.reloadData()
    }
    
    // 設置 PageControl
    private func setPageControlLayout() {
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension CarouselViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 設定資料數量
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 設定 Cell
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CarouselCollectionViewCell.self),
            for: indexPath
        ) as? CarouselCollectionViewCell
        else {
            return .init()
        }
        cell.setImage(data[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 根據滑動的範圍 移動 pageControl
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = Int(page)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 當使用者開始滑動 停止輪播
        automaticCarouselService.endCarousel()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 當使用者停止滑動 準備開始輪播
        automaticCarouselService.restart(currentIndex: pageControl.currentPage)
    }
}
