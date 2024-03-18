//
//  CreateGridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-13.
//

import SwiftUI
import PhotosUI

struct CreateGridImageView: View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @EnvironmentObject var createAdViewModel: CreateAdViewModel
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                ForEach(0..<createAdViewModel.selectedImages.count, id: \.self) { i in
                    Image(uiImage: createAdViewModel.selectedImages[i])
                        .resizable()
                        .scaledToFit()
                }
            }
            .cornerRadius(5)
            .shadow(color: .gray, radius: 6, x: 3, y: 4)
            .onChange(of: pickerItems) { newValue in
                Task {
                    createAdViewModel.selectedImages.removeAll()
                    
                    for item in pickerItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    createAdViewModel.selectedImages.append(uiImage)
                                }
                            }
                        }
                    }
                }
            }
            
            if pickerItems.isEmpty {
                
                PhotosPicker("Lägg till bilder +", selection: $pickerItems, maxSelectionCount: 10, matching: .images)
                    .frame(width: 380, height: 200)
                    .foregroundColor(Color.blue)
                    .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
            } else {
                
                PhotosPicker("Lägg till bilder +", selection: $pickerItems, maxSelectionCount: 10, matching: .images)
                    .frame(width: 380, height: 30)
                    .foregroundColor(Color.blue)
                    .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                    .cornerRadius(5)
                    .padding(.bottom, 10)
                    
            }
        }
    }
}

struct CreateGridImageView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAdvertisementView().environmentObject(AuthViewModel())
    }
}
