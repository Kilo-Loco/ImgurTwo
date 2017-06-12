//
//  ImgurCell.swift
//  Imgur2
//
//  Created by Kyle Lee on 6/12/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

class ImgurCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with imgur: Imgur) {
        titleLabel.text = imgur.title
        imgur.image { (image) in
            self.imageView.image = image
        }
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        imageView.image = nil
    }
}
