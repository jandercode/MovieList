//
//  ImageLoader.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-09.
//

import SwiftUI
import UIKit

var _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    var imageCache = _imageCache
    
    func loadImage(url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        // AsyncImage?
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
                print(urlString)
            }
        }
    }

    
}
