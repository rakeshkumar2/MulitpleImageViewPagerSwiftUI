//
//  HomeViewModel.swift
//  MultipleImageViewer
//
//  Created by Rakesh Verma				 on 04/03/21.
//
import UIKit
import SwiftUI
import Foundation

class HomeViewModel: ObservableObject {
    @Published var allImages: [String] = ["team1","team2","team3","team4", "team1"]
    
    @Published var showImageViewer = false
    @Published var selectedImageID : String = ""
    
    @Published var pageViewerOffset: CGSize = .zero
    
    @Published var bgOpacity:Double = 1
    
    @Published var imageScale: CGFloat = 1
    
    func onChangeValue(value: CGSize){
        //updating offset
        pageViewerOffset = value
        
        // Calculating opacity
        let halHeight = UIScreen.main.bounds.height / 2
        let progress = pageViewerOffset.height / halHeight
        
        withAnimation(.default){
            bgOpacity  = Double(1 - (progress < 0 ? -progress : progress))
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation(.easeInOut){
            var translation = value.translation.height
            if translation < 0{
                translation = -translation
            }
            if translation < 250{
                pageViewerOffset = .zero
                bgOpacity = 1
            }else{
                showImageViewer.toggle()
                pageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
