//
//  PostView.swift
//  MemoryManagmentUIKit
//
//  Created by Alibek Baisholanov on 20.02.2025.
//

import Foundation
import UIKit

class PostView: UIView, ImageLoaderDelegate{
    var imageLoader: ImageLoader?
    
    func setupImageLoader() {
        imageLoader = ImageLoader()
        imageLoader?.delegate = self
        imageLoader?.loadImage(url: URL(string: "https://example.com/image.jpg")!)
    }
    
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        // Обработка успешной загрузки изображения
        print("Image loaded")
    }
    
    func imageLoader(_ loader: ImageLoader, didFailWith error: Error) {
        // Обработка ошибки загрузки изображения
        print("Error loading image: \(error.localizedDescription)")
    }
}
