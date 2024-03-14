//
//  CreateGridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-13.
//

import SwiftUI
import PhotosUI

struct CreateGridImageView: View {
    
    let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    var body: some View {
        VStack {
            PhotosPicker(
                selection: $pickerItems,
                maxSelectionCount: 10,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Lägg till bilder")
                        .frame(width: 350, height: 200)
                        .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                        .cornerRadius(5)
                }
                .onChange(of: pickerItems) { newValue in
                    Task {
                        selectedImages.removeAll()
                        
                        for item in pickerItems {
                            if let loadedData = try await item.loadTransferable(type: Data.self) {
                                if let loadedImage = UIImage(data: loadedData) {
                                    selectedImages.append(loadedImage)
                                }
                            }
                        }
                    }
                }
            
            if index < selectedImages.count {
                Image(uiImage: selectedImages[index])
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getWidth(index: index), height: 120)
                    .cornerRadius(0)
            }
            
            if selectedImages.count > 4 && index == 3 {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.black.opacity(0.5))
                
                let remainingImages = selectedImages.count - 4
                Text("+\(remainingImages)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
    
    func getWidth(index: Int) -> CGFloat {
        let width = getScreenRect().width
        
        if selectedImages.count % 2 == 0 {
            return width / 2
        } else {
            if index == selectedImages.count - 1 {
                return width
            } else {
                return width / 2
            }
        }
    }
}

struct CreateGridImageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGridImageView(index: 0)
    }
}

extension View {
    func getScreenRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
