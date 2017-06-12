//
//  Imgur.swift
//  Imgur2
//
//  Created by Kyle Lee on 6/12/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

struct Imgur {
    
    private let id: String
    private let link: String
    
    let title: String
    
    init?(json: JSON) {
        guard let id = json["id"] as? String,
            let title = json["title"] as? String,
            let link = json["link"] as? String
            else { return nil }
        
        self.id = id
        self.title = title
        self.link = link
    }
    
    func image(completion: @escaping (UIImage) -> Void) {
        if let image = imageCache.image(forKey: id) {
            completion(image)
        } else {
            NetworkingService.shared.downloadImage(fromLink: link) { (image) in
                imageCache.add(image, forKey: self.id)
                completion(image)
            }
        }
    }
}
