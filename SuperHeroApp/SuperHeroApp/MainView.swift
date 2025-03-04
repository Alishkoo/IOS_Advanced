//
//  MainView.swift
//  SuperHeroApp
//
//  Created by Alibek Baisholanov on 01.03.2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: SuperHeroViewModel
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.hero?.imageUrl){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 100,height: 100)
                case .failure(let error):
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            .padding(32)
            
            Group {
                if let hero = viewModel.hero {
                    Text("""
                            Name: \(hero.name!)
                            Full Name: \((hero.biography?.fullName!)!)
                            Place of Birth: \((hero.biography?.placeOfBirth)!)
                            Publisher: \((hero.biography?.publisher)!)
                            
                            Gender: \((hero.appearance?.gender)!)
                            Race: \(hero.appearance?.race ?? "Unknown")
                            Eye Color: \(hero.appearance?.eyeColor ?? "Unknown")
                            Hair Color: \(hero.appearance?.hairColor ?? "Unknown")
                            
                            """)
                    .font(.title3)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                } else {
                    Text("No hero selected")
                        .font(.title3)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            Spacer()
            
            TextField("Enter the name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            
            Button {
                Task {
                    await viewModel.searchByName()
                }
            } label: {
                Text("Search by name")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 340)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(12)
            }
//            .padding()
            
            
            Button {
                Task {
                    await viewModel.fetchHero()
                }
            } label: {
                Text("Roll Hero")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 340)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(12)
            }
            
            
            Button {
                Task {
                    await viewModel.addToFavourites()
                }
            } label: {
                Text("Add to favourite")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 340)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(12)
            }

            
            Button("Open Bottom Sheet") {
                isPresented = true
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: 340)
            .padding()
            .background(Color.gray)
            .cornerRadius(12)
            
        }
        .sheet(isPresented: $isPresented) {
            BottomSheetView(viewModel: viewModel)
        }
    }
}

#Preview {
    let viewModel = SuperHeroViewModel()
    MainView(viewModel: viewModel)
}
