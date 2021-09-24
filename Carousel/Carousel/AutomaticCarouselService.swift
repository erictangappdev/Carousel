//
//  AutomaticCarouselService.swift
//  Carousel
//
//  Created by 唐紹桓 on 2021/8/27.
//

import UIKit

final class AutomaticCarouselService {
    
    private let collectionView: UICollectionView

    private var currentIndex: Int // 當前位置
    private let dataCount: Int // 資料總數

    private let carouselSecondCount: Int = 5 // 切換到下一張圖片的時間
    private let restartSecondCount: Int = 5 // 停止之後重新開始的時間

    private var carouselTimer: Timer? // 執行輪播的 Timer
    private var countDownTimer: Timer? // 倒數計時的 Timer
    
    init(collectionView: UICollectionView, currentIndex: Int, dataCount: Int) {
        self.collectionView = collectionView
        self.currentIndex = currentIndex
        self.dataCount = dataCount
    }
        
    // 移動圖片
    private func moveImage() {
        carouselTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(carouselSecondCount), repeats: true, block: { [unowned self] _ in
            // 取得最後一筆資料的 index
            let dataLastIndex = dataCount - 1
            // 計算下一個 index
            let nextIndex = currentIndex + 1
            // 是否超過資料數量
            let overDataCount = nextIndex > dataLastIndex
            
            overDataCount ? resetIndex() : moveToNextIndex()
            
            print("顯示下一張圖片 currentIndex: \(currentIndex)")
            collectionView.scrollToItem(
                at: IndexPath(item: currentIndex, section: 0),
                at: .centeredHorizontally,
                animated: true)
        })
    }
    
    // 倒數並準備重新開始輪播
    private func countDownForRestart() {
        var count = 0
        
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [unowned self] _ in
            count += 1
            print("\(count) 秒 將於第 \(restartSecondCount) 秒開始自動輪播")
            
            if count >= restartSecondCount {
                startCarousel()
                removeCountDownTimer()
            }
        })
    }
    
    // 重新開始輪播
    public func restart(currentIndex: Int) {
        // 取得使用者可能滾動過後的位置
        self.currentIndex = currentIndex
        countDownForRestart()
    }
    
    // 開始輪播
    public func startCarousel() {
        print("開始輪播")
        moveImage()
    }
    
    // 結束輪播
    public func endCarousel() {
        print("使用者已接手操作，停止輪播")
        removeCarouselTimer()
        removeCountDownTimer()
    }
    
    // 重置 index
    private func resetIndex() {
        currentIndex = 0
    }
    
    // 移動到下一個 index
    private func moveToNextIndex() {
        currentIndex += 1
    }
}

extension AutomaticCarouselService {
    
    func removeCountDownTimer() {
        countDownTimer?.invalidate()
        countDownTimer = nil
    }
    
    func removeCarouselTimer() {
        carouselTimer?.invalidate()
        carouselTimer = nil
    }
}
