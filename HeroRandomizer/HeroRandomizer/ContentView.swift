//
//  ContentView.swift
//  HeroRandomizer
//
//  Created by Arman Myrzakanurov on 28.02.2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.selectedHero?.imageUrl) { phase in
                switch phase {
                case .empty:
                    Color.teal
                        .frame(height: 300)
                case .success(let image):
                    image
                        .resizable()
                        .frame(height: 300)
                case .failure(let error):
                    Color.red
                        .frame(height: 300)
                }
            }
            .padding(32)

            Spacer()

            Button {
                Task {
                    await viewModel.fetchHero()
                }
            } label: {
                Text("Roll Hero")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

        }
    }
}

#Preview {
    let viewModel = ViewModel()
    ContentView(viewModel: viewModel)
}
