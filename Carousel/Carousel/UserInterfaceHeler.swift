//
//  UserInterfaceHeler.swift
//  Carousel
//
//  Created by 唐紹桓 on 2021/9/24.
//

import UIKit

extension UICollectionView {
    
    typealias CollectionViewOwner = (UICollectionViewDelegate & UICollectionViewDataSource)
    
    static func make(owner: CollectionViewOwner) -> UICollectionView {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = owner
        
        collectionView.dataSource = owner
        
        return collectionView
    }
}

extension UIPageControl {
    
    static func make(numberOfPages: Int) -> UIPageControl {
        
        let pageControl = UIPageControl()
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.backgroundStyle = .prominent
        
        pageControl.numberOfPages = numberOfPages
        
        pageControl.pageIndicatorTintColor = UIColor.black
        
        pageControl.currentPageIndicatorTintColor = UIColor.white

        return pageControl
    }
}
