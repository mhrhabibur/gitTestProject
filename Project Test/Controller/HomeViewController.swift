//
//  ViewController.swift
//  Project Test
//
//  Created by Habibur Rahman on 1/1/23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var currentIndex = 0
    var timer: Timer?
    
    var cars = ["Audi", "BMW", "Hundai", "Mercedece", "Nissan", "Suzuki", "Toyota", "Triver"]
    var categories = ["Sedan", "SUV", "SportsCar"]
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var newCollectionView: UICollectionView!
    
    @IBOutlet var pageView: UIPageControl!
    
    let collectionViewIdentifier = "cell"
    let categoryCollectionViewIdentifier = "categoryCell"
    let newCollectionViewIdentifier = "newCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
        
        categoryCollectionView.layer.borderColor = UIColor.gray.cgColor
        categoryCollectionView.layer.borderWidth = 0.5
        
        self.view.addSubview(collectionView)
        self.view.addSubview(categoryCollectionView)
        self.view.addSubview(newCollectionView)
      
        pageView.numberOfPages = cars.count
        pageView.currentPage = currentIndex

        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.badge"), style: .plain, target: self, action: #selector(rightBarItemTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(cars[currentIndex])", image: nil, target: self, action: #selector(leftBarItemTapped))
    }

    @objc func rightBarItemTapped() {
        let alert = UIAlertController(title: "Notification", message: "You have no notification", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc func leftBarItemTapped() {
        print("LeftBar Item Tapped")
        let alert = UIAlertController(title: "\(cars[currentIndex])", message: "You have tapped on \(cars[currentIndex])", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc func slideToNext() {
        if currentIndex < cars.count - 1 {
            currentIndex += 1
            pageView.currentPage = currentIndex
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(cars[currentIndex])", image: nil, target: self, action: #selector(leftBarItemTapped))
            
        } else {
            currentIndex = 0
            pageView.currentPage = currentIndex
        }
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView {
            return cars.count
        } else if
            categoryCollectionView == self.categoryCollectionView {
            return cars.count
        } else if newCollectionView == self.newCollectionView {
            return cars.count
            }
        
            return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdentifier, for: indexPath) as! CollectionViewCell

            cellA.imageView.image = UIImage(named: cars[indexPath.row])
                return cellA
            } else if categoryCollectionView == self.categoryCollectionView {
                let cellB = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categoryCollectionViewIdentifier, for: indexPath) as! CategoryCollectionViewCell
                cellB.imageView.image = UIImage(named: cars[indexPath.row])
                
                return cellB
            } else  {
                
                
                let cellC = newCollectionView.dequeueReusableCell(withReuseIdentifier: newCollectionViewIdentifier, for: indexPath) as! NewCollectionViewCell
                
                cellC.imageView.image = UIImage(named: cars[indexPath.row])
                cellC.carNameLabel.text = "\(cars[indexPath.row])"
                cellC.locationLabel.text = cars[indexPath.row]
                cellC.priceLabel.text = cars[indexPath.row]
                
                
                return cellC
            }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
   


}

