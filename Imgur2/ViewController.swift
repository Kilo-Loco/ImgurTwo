//
//  ViewController.swift
//  Imgur2
//
//  Created by Kyle Lee on 6/12/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgurs = [Imgur]()

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingService.shared.getImgurs { (response) in
            self.imgurs = response.imgurs
            self.collectionView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgurs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgurCell", for: indexPath) as? ImgurCell else { return UICollectionViewCell() }
        cell.configure(with: imgurs[indexPath.item])
        return cell
    }
}
