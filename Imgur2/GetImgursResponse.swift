//
//  GetImgursResponse.swift
//  Imgur2
//
//  Created by Kyle Lee on 6/12/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import Foundation

struct GetImgursResponse {
    
    let imgurs: [Imgur]
    
    init(json: JSON) throws {
        guard let data = json["data"] as? [JSON] else { throw MyError.someError }
        let imgurs = data.map{ Imgur(json: $0) }.flatMap{ $0 }
        self.imgurs = imgurs
    }
}
