//
//  Trend.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 04.02.2025.
//

import SwiftUI

struct Trend: View {
    var body: some View {
        trend(dataM: MacData.tSimple)
    }
}

#Preview {
    Trend()
}


struct trend: View{
    var dataM: TrendModel
    var body: some View{
        ZStack{
            Image(dataM.image)
                .resizable()
                .scaledToFill()
                .frame(width: 275, height: 150)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "heart")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(dataM.count)
                        .font(.headline)
                }
                .padding(5)
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                Spacer()
                HStack{
                    Image(dataM.avatar)
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .clipped()
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        )
                    Spacer()
                }
            }
            .frame(width: 265, height: 145)
        }
    }
}
