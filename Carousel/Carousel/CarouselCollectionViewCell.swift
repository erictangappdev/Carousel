//
//  CarouselCollectionViewCell.swift
//  Carousel
//
//  Created by 唐紹桓 on 2021/8/26.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
       
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setLayout()
    }
    
    public func setImage(_ image: UIImage) {
        
        imageView.image = image
    }
    
    private func setLayout() {
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
