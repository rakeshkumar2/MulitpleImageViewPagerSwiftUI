//
//  GridImageView.swift
//  MultipleImageViewer
//
//  Created by Rakesh Verma				 on 04/03/21.
//

import SwiftUI

struct GridImageView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    var index: Int
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                homeViewModel.selectedImageID = homeViewModel.allImages[index]
                homeViewModel.showImageViewer.toggle()
                
                
            }
        }, label: {
            ZStack{
                if index <= 3{
                    Image(homeViewModel.allImages[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (getRect().width - 60) / 2, height: 120)
                        .cornerRadius(12)
                        
                }
                if homeViewModel.allImages.count > 4 && index == 3{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.3))
                }
            }
        })
        
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
