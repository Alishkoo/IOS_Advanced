//
//  Router.swift
//  ConcurrencyTask
//
//  Created by Alibek Baisholanov on 01.04.2025.
//

import SwiftUI
import Foundation

final class Router {
    var rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func showDetailView(image: Image) {
        let detailVC = UIHostingController(rootView: DetailView(image: image))
        rootViewController.pushViewController(detailVC, animated: true)
    }
}
