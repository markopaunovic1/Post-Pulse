//
//  ImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-07.
//

import SwiftUI

struct ImageView: View {
    
    @EnvironmentObject var itemViewModel: ItemViewModel
    @GestureState var draggingOffset: CGSize = .zero
    
    let item: Item2
    
    
    init(item: Item2) {
        self.item = item
    }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(itemViewModel.backGroundOpacity)
                .ignoresSafeArea()
            
            TabView(selection: $itemViewModel.selectedImageID) {
                ForEach(item.imageURL, id: \.self) { imageName in
                    let imageURL = URL(string: imageName) ?? URL(string: "")
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            // Placeholder or loading view
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(y: itemViewModel.imageViewerOffset.height)
                        case .failure(let error):
                            // Placeholder for failure
                            Text("Failed to load image \(error.localizedDescription)")
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .overlay(
                Button(action: {
                    withAnimation(.default) {
                        itemViewModel.showImageViewer.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.white.opacity(0.35))
                        .clipShape(Circle())
                })
                .padding(10)
                ,alignment: .topTrailing
            )
        }
        .gesture(DragGesture().updating($draggingOffset, body: { (value, outValue, _) in
            
            outValue = value.translation
            itemViewModel.onchange(value: draggingOffset)
            
        }).onEnded(itemViewModel.onEnd(value:))
        )
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
