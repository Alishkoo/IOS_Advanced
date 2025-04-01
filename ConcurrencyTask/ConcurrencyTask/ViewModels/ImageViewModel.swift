//
//  ImageViewModel.swift
//  ConcurrencyTask
//
//  Created by Alibek Baisholanov on 01.04.2025.
//


import SwiftUI
import Foundation


final class ImageViewModel: ObservableObject {
    @Published var images : [ImageModel] = []
    @Published var errorMessage: ErrorMessage?
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImages(){
        var tempImages: [ImageModel] = []
        let group = DispatchGroup()
        
        let urlStrings: [String] = (0...5).map { _ in
            "https://picsum.photos/id/\(Int.random(in: 0...500))/500"
        }
        
        for url in urlStrings {
            group.enter()
            downloadImage(urlString: url) { model in
                if let model = model {
                    tempImages.append(model)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.images += tempImages
        }
    }
    
    
    private func downloadImage(urlString: String, completion: @escaping (ImageModel?) -> Void){
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            let model = ImageModel(image: Image(uiImage: cachedImage))
            completion(model)
            return
            
        }
        
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage?.message = "Error downloading image: \(error.localizedDescription)"
                }
                completion(nil)
                return
            }
            
            if let safeData = data {
                guard let image = UIImage(data: safeData) else {
                    DispatchQueue.main.async {
                        self.errorMessage?.message = "Failed to decode image \(urlString)"
                    }
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(image, forKey: urlString as NSString)
                
                let convertedImage = Image(uiImage: image)
                let model = ImageModel(image: convertedImage)
                completion(model)
            }
            
        }
        .resume()
    }
    
    
    func refreshImages() async {
        await MainActor.run{
            self.images.removeAll()
        }
        
        getImages()
    }
}
