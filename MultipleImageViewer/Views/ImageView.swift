//
//  ImageView.swift
//  MultipleImageViewer
//
//  Created by Rakesh Verma				 on 04/03/21.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @GestureState var draggingOffset: CGSize = .zero
    var body: some View {
        ZStack{
            Color.black
                .opacity(homeViewModel.bgOpacity)
                .ignoresSafeArea()
            ScrollView(.init()){
                TabView(selection: $homeViewModel.selectedImageID){
                    ForEach(homeViewModel.allImages, id: \.self){image in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(image)
                            .scaleEffect(homeViewModel.selectedImageID == image ? (homeViewModel.imageScale > 1 ? homeViewModel.imageScale : 1) : 1)
                            .offset(y: homeViewModel.pageViewerOffset.height)
                            .gesture(
                                MagnificationGesture().onChanged({ (value) in
                                    homeViewModel.imageScale = value
                                }).onEnded({ (_) in
                                    withAnimation(.default){
                                        homeViewModel.imageScale = 1
                                    }
                                })
                                .simultaneously(with: TapGesture(count: 2).onEnded({
                                    withAnimation{
                                        homeViewModel.imageScale = homeViewModel.imageScale > 1 ? 1 : 4
                                    }
                                }))
                            )
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .overlay(
                // Close button
                    Button(action: {
                        withAnimation(.default) {
                            homeViewModel.showImageViewer.toggle()
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.35))
                            .clipShape(Circle())
                    })
                    .padding(10)
                    ,alignment: .topTrailing
                )
            }
        }
        .gesture(DragGesture().updating($draggingOffset, body: { (value, ouputValue, _) in
            ouputValue = value.translation
            homeViewModel.onChangeValue(value: draggingOffset)
        }).onEnded(homeViewModel.onEnd(value:)))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
