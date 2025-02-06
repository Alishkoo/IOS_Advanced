//
//  Profile.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 06.02.2025.
//

import SwiftUI

struct Profile: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var dataM: PostModel
    var body: some View {
        ScrollView{
            VStack{
                Image(dataM.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                VStack{
                    HStack{
                        Text(dataM.by).bold()
                            .font(.title)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                            .offset(y:3)
                    }
                }
                HStack(spacing: 60){
                    info(postCount: "10", title: "Posts")
                    info(postCount: "154K", title: "Followers")
                    info(postCount: "534", title: "Following")
                }
                Divider()
                LazyVGrid(columns: columns){
                    ForEach(MacData.gallery){ items in
                        Image(items.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 115, height: 150)
                            .cornerRadius(20)
                    }
                }
            }
            .padding()
        }
    }
}

struct info : View{
    var postCount = ""
    var title = ""
    
    var body: some View{
        VStack{
            Text(postCount)
                .font(.headline)
            Text(title)
                .font(.headline)
                .foregroundColor(.gray )
        }
    }
}

#Preview {
    Profile(dataM: MacData.pSimple)
}
