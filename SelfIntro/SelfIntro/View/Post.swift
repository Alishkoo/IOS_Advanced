//
//  Post.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 04.02.2025.
//

import SwiftUI

struct Post: View {
    var body: some View {
        post(dataM: MacData.pSimple)
    }
}

struct post: View {
    var dataM: PostModel
    var body: some View{
        VStack(alignment: .leading){
            Image(dataM.image)
                .resizable()
                .scaledToFill()
                .frame(width: 190, height: 130)
                .cornerRadius(20)
            VStack(alignment: .leading, content: {
                Text(dataM.title).bold()
                    .font(.headline)
                    .minimumScaleFactor(0.8)
                HStack{
                    Text("by")
                        .font(.headline).foregroundColor(.gray)
                    Text(dataM.by).foregroundColor(.gray)
                }
            })
            .padding(.horizontal, 15)
            Spacer()
            
            
        }
        .frame(width: 170, height: 180)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    Post()
}
