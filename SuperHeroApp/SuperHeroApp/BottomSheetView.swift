//
//  BottomSheetView.swift
//  SuperHeroApp
//
//  Created by Alibek Baisholanov on 04.03.2025.
//

import SwiftUI

struct BottomSheetView: View {
    @ObservedObject var viewModel: SuperHeroViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.favouriteHeroes, id: \.id){ hero in
                Text("\(hero.name ?? "Does not have a name")")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Button("Close") {
                dismiss()
            }
            .font(.headline)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    var viewModel = SuperHeroViewModel()
    BottomSheetView(viewModel: viewModel)
}
