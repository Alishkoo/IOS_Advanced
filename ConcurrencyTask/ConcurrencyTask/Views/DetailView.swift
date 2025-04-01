//
//  DetailView.swift
//  ConcurrencyTask
//
//  Created by Alibek Baisholanov on 01.04.2025.
//

import SwiftUI

struct DetailView: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 200, height: 200)
    }
}

