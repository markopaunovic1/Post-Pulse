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
    
    init( item: Item2) {
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
        ImageView(item: Item2(id: UUID(), itemName: "Marko", imageURL: ["https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2FB1059BD4-EC9A-4E1B-91AC-313249ED41EE.jpg?alt=media&token=95da230a-9770-4718-b6cc-ea4f5f0c09a3", "https://example.com/image2.jpg", "https://firebasestorage.googleapis.com:443/v0/b/post-pulse-52f96.appspot.com/o/images%2F2B97D72E-931F-4B80-8CF3-A2EF4778723D.jpg?alt=media&token=36816ceb-e1ea-4747-b5f5-4eabc1b6f8c9"], description: "asd", price: "123", category: .bostad))
    }
}
