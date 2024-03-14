//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI
import PhotosUI

struct AddAdvertisementView: View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @State private var itemName = ""
    @State private var price = ""
    @State private var description = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 0) {
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        selectedImages[i]
                            .resizable()
                            .scaledToFit()
                    }
                }
                .cornerRadius(5)
                .onChange(of: pickerItems) { newValue in
                    Task {
                        selectedImages.removeAll()
                        
                        for item in pickerItems {
                            if let loadedImage = try await item.loadTransferable(type: Image.self) {
                                selectedImages.append(loadedImage)
                            }
                        }
                    }
                }
                
                if pickerItems.isEmpty {
                    
                    PhotosPicker("Lägg till bilder", selection: $pickerItems, maxSelectionCount: 10, matching: .images)
                        .frame(width: 360, height: 200)
                        .foregroundColor(Color.blue)
                        .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                        .cornerRadius(5)
                } else {
                    
                    PhotosPicker("Lägg till bilder", selection: $pickerItems, maxSelectionCount: 10, matching: .images)
                        .frame(width: 360, height: 30)
                        .foregroundColor(Color.blue)
                        .background(Color(red: 229/255, green: 229/255, blue: 229/255))
                        .cornerRadius(5)
                }
                
                HStack() {
                    TextField("Rubrik:", text: $itemName)
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Spacer()
                    TextField("pris:", text: $price)
                        .keyboardType(.numberPad)
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
                .padding(10)
                .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                .cornerRadius(10)
                .shadow(color: .gray, radius: 6, x: 3, y: 4)
                
                Divider()
                TextField("Beskrivning..." ,text: $description, axis: .vertical)
                    .padding(10)
                    .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 3, y: 4)
                Divider()
                
                SellerCardInfoView().environmentObject(AuthViewModel())
                
                
                Button {
                    print("Ad created")
                } label: {
                    Text("Skapa annons +")
                        .padding(13)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        
                }
                
            }
            .padding(10)
        }
    }
}



struct AddAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        AddAdvertisementView().environmentObject(AuthViewModel())
    }
}
