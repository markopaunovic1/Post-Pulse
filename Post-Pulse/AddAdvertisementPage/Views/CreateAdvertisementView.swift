//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI
import PhotosUI

struct CreateAdvertisementView: View {
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @State private var itemName = ""
    @State private var price = ""
    @State private var description = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var createAdViewModel: CreateAdViewModel
    
    var body: some View {
        
        ZStack {
            Color(red: 194/255, green: 196/255, blue: 207/255)
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack {
                    CreateGridImageView()
                    
                    Divider()
                        .padding(.bottom, 10)
                    
                    HStack() {
                        TextField("Rubrik:", text: $itemName)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        Divider()
                        TextField("Pris:", text: $price)
                            .fontWeight(.bold)
                            .keyboardType(.numberPad)
                            .fontWeight(.medium)
                            .lineLimit(2)
                    }
                    .padding(10)
                    .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 6, x: 3, y: 4)
                    .padding(.bottom, 10)
                    
                    Divider()
                    TextField("Beskrivning..." ,text: $description, axis: .vertical)
                        .padding(10)
                        
                        .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 6, x: 3, y: 4)
                        .padding(.vertical, 10)
                    Divider()
                    
                    Button {
                        Task {
                            if let userId = authViewModel.currentUser?.id {
                                try await createAdViewModel.addAdvertisement(itemName: itemName, price: price, description: description, userId: userId)
                            } else {
                                print("User not logged in")
                            }
                        }
                        
                    } label: {
                        Text("Skapa annons +")
                            .padding(13)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 6, x: 3, y: 4)
                        
                    }
                }
                .padding(10)
            }
        }
    }
}

protocol CreationFormProtocol {
    var inputIsValid: Bool { get }
}


struct CreateAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAdvertisementView().environmentObject(AuthViewModel())
    }
}
