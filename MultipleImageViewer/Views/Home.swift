//
//  Home.swift
//  MultipleImageViewer
//
//  Created by Rakesh Verma				 on 04/03/21.
//

import SwiftUI

struct Home: View {
    @StateObject var homeViewModel = HomeViewModel()
    init() {
        // Stop bounces in Tabview
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        ScrollView{
            HStack{
                Text("Multi Images Viewer").font(.title).bold().foregroundColor(.black)
            }
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
            LazyVGrid(columns: columns, alignment: .center, spacing: 10, content:{
                ForEach(homeViewModel.allImages.indices, id: \.self){index in
                    GridImageView(index: index)
                        .padding(10)
                }
            }).padding()
        }
        //setting Image view pager
        .overlay(
            ZStack{
                if homeViewModel.showImageViewer{
                    ImageView()
                }
            }
        )
        
        // Setting environment object
        .environmentObject(homeViewModel)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
