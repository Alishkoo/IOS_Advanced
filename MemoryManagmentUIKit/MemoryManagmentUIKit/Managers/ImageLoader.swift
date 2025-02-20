//
//  ImageLoader.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation
import UIKit

protocol ImageLoaderDelegate: AnyObject {
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage)
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error)
}

class ImageLoader {
    weak var delegate: ImageLoaderDelegate?
    var completionHandler: ((UIImage?) -> Void)?
    
    func loadImage(url: URL){
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.delegate?.imageLoader(self, didFailWith: error)
                    self.completionHandler?(nil)
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                let error = NSError(domain: "ImageLoaderError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Image not found"])
                DispatchQueue.main.async {
                    self.delegate?.imageLoader(self, didFailWith: error)
                    self.completionHandler?(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.imageLoader(self, didLoad: image)
                self.completionHandler?(image)
            }
        }
        task.resume()
    }
}
