//
//  Collection1VC.swift
//  CollectionHorizontalPaging
//
//  Created by Sergey Leskov on 9/1/18.
//  Copyright © 2018 Sergey Leskov. All rights reserved.
//

import UIKit


class CollectionVC: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    fileprivate var items: [String] = []
    fileprivate let cellName = "Cell"
    
    var colorCell = UIColor.blue
    
    //==============================================================
    // MARK: - general
    //==============================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.cellName)
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        for i in 1...5 {
            let string = String(i)
            self.items.append(string)
        }
        
        self.pageControl.numberOfPages = self.items.count
        self.pageControl.currentPage = 0
        self.pageControl.isUserInteractionEnabled = false
        
        self.configLayoutCollectionView()
        self.configPageControl()
    }
    
    //==============================================================
    // MARK: - config
    //==============================================================
    fileprivate  func configLayoutCollectionView()  {
        let spacingBitweenCell: CGFloat = 0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = spacingBitweenCell
        layout.minimumLineSpacing = spacingBitweenCell
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        collectionView!.collectionViewLayout = layout
    }
    
    fileprivate  func configPageControl()  {
        self.pageControl.pageIndicatorTintColor = UIColor.blue
         self.pageControl.currentPageIndicatorTintColor = UIColor.yellow
    }
    
}


//==============================================================
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
//==============================================================
extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellName, for: indexPath) as! CollectionViewCell
        
        let item = self.items[indexPath.row]
        
        cell.backgroundColor = self.colorCell
        cell.labelUI.text = item
        
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = collectionView.indexPathForItem(at: center) {
            self.pageControl.currentPage = ip.row
        }
    }
    
}

