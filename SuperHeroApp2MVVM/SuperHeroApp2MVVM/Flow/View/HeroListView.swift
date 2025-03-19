//
//  MainView.swift
//  SuperHeroApp2MVVM
//
//  Created by Alibek Baisholanov on 15.03.2025.
//

import SwiftUI


struct HeroListView: View {
    @StateObject var viewModel: HeroViewModel
    
    var body: some View {
        VStack{
            Text("Hero List")
                .font(.largeTitle)
            
            Divider()
                .padding(16)
            
            heroList()
            
            Spacer()
        }
        .task {
            await viewModel.loadHeroes()
        }
    }
}

extension HeroListView {
    @ViewBuilder
    private func heroList() -> some View{
        ScrollView{
            LazyVStack{
                ForEach(viewModel.heroes) {model in
                    heroCard(model: model)
                        .padding(16)
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func heroCard(model: HeroModel) -> some View {
        HStack(){
            AsyncImage(url: model.imageUrl) {phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                        .padding(16)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 16)
                case .failure(let error):
                    Color.red
                        .frame(width: 100, height: 100)
                        .padding(16)
                }
                
            }
            
            Spacer()
            
            VStack{
                Text(model.title)
                Text(model.description)
                Text(model.apperance)
                Text(model.publisher)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .onTapGesture {
            viewModel.showDetailView(id: model.id)
            
        }
    }
}

//
//#Preview {
//    let viewModel = HeroViewModel()
//    HeroListView(viewModel: viewModel)
//}
