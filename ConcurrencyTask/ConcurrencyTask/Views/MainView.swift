//
//  MainView.swift
//  ConcurrencyTask
//
//  Created by Alibek Baisholanov on 01.04.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var imageViewModel: ImageViewModel
    var router: Router
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(imageViewModel.images) { model in
                    imageCell(for: model)
                }
            }
            .padding(12)
        }
        .scrollIndicators(.hidden)
        .refreshable {
            await imageViewModel.refreshImages()
        }
        .onAppear {
            imageViewModel.getImages()
        }
        .alert(item: $imageViewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
        Button("I need more PHOTOS!") {
            imageViewModel.getImages()
        }.buttonStyle(.bordered)
        
    }
    
    // Вынесенная логика для отображения ячейки
    private func imageCell(for model: ImageModel) -> some View {
        model.image
            .resizable()
            .scaledToFit()
            .cornerRadius(16)
            .frame(height: 200)
            .shadow(radius: 4)
            .onAppear {
                if model == imageViewModel.images.last {
                    imageViewModel.getImages()
                }
            }
    }
}

//#Preview {
//    let imageViewModel = ImageViewModel()
//    MainView(imageViewModel: imageViewModel)
//}
