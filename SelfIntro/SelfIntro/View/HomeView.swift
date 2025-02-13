//
//  HomeView.swift
//  SelfIntro
//
//  Created by Alibek Baisholanov on 06.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PostGrip()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Text("Trending").bold()
                        .font(.title)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(MacData.tItems) { item in
                                trend(dataM: item)
                            }
                        }
                    }
                    
                    Text("Posts").bold()
                        .font(.title)
                    LazyVGrid(columns: columns, content: {
                        ForEach(MacData.pItems){ item in
                            post(dataM: item)
                                .onTapGesture {
                                    viewModel.selected = item
                                }
                        }
                    })
                }
            }
            .padding()
            .sheet(isPresented: $viewModel.didSetPost, content: {
                Profile(dataM: viewModel.selected!)
            })
        }
    }
}

#Preview {
    HomeView()
}
