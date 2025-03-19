//
//  DetailHeroView.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 19.03.2025.
//

import SwiftUI

struct DetailHeroView: View {
    @StateObject var viewModel: DetailViewModel
    var id: Int
    
    var body: some View {
        VStack{
            AsyncImage(url: viewModel.singleHero?.imageUrl){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .padding(16)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding(16)
                    
                case .failure(let error):
                    Color.red
                        .frame(width: 300, height: 300)
                        .padding(16)
                }
            }
            
            Spacer()
            
            Text(viewModel.singleHero?.title ?? "No name")
            Text(viewModel.singleHero?.description ?? "No description")
            Text(viewModel.singleHero?.publisher ?? "No Publisher")
            Text(viewModel.singleHero?.apperance ?? "No appereance")
            
            Spacer()
        }
        .task {
            await viewModel.loadHero(heroId: id)
        }
    }
}

//#Preview {
//    let viewModel = HeroViewModel()
//    DetailHeroView(viewModel: viewModel)
//}
