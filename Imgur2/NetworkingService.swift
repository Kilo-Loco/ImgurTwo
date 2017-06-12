//
//  NetworkingService.swift
//  Imgur2
//
//  Created by Kyle Lee on 6/12/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
    let session = URLSession.shared
    
    func getImgurs(success successBlock: @escaping (GetImgursResponse) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/r/cats") else { return }
        var request = URLRequest(url: url)
        request.addValue("Client-ID 40dfbed2b6935ec", forHTTPHeaderField: "authorization")
        
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                print(json)
                let getImgursResponse = try GetImgursResponse(json: json)
                DispatchQueue.main.async {
                    successBlock(getImgursResponse)
                }
            } catch {}
        }.resume()
    }
    
    func downloadImage(fromLink link: String, success successBlock: @escaping (UIImage) -> Void) {
        guard let url = URL(string: link) else { return }
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
        }.resume()
    }
}
