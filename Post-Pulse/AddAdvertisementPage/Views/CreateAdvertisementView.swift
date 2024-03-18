//
//  SellerAdvertisementView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI
import PhotosUI

struct CreateAdvertisementView: View {
    
    enum ActiveAlert {
        case first, second
    }
    
    @State private var itemName = ""
    @State private var price = ""
    @State private var description = ""
    @State private var showingAlert = false
    @State private var handleInputAlert: ActiveAlert = .second
    
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
                        // Handles input validation before uploading to firebase
                        if !itemName.isEmpty && !price.isEmpty && !description.isEmpty {
                            Task {
                                if let userId = authViewModel.currentUser?.id {
                                    createAdViewModel.uploadItem(itemName: itemName, price: price, description: description, userId: userId, images: createAdViewModel.selectedImages)
                                }
                            }
                            self.handleInputAlert = .first
                        } else {
                            self.handleInputAlert = .second
                        }
                        self.showingAlert = true
                    } label: {
                        Text("Skapa annons +")
                            .padding(13)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 6, x: 3, y: 4)
                        
                    }
                    // Alert pop up if the ad is created
                    .alert(isPresented: $showingAlert) {
                        switch handleInputAlert {
                        case .first:
                            return Alert(
                                title: Text("Annonsen har skapats!"),
                                message: Text("Återgå till start"),
                                primaryButton: .default(Text("Huvudmeny")) {
                                    print("successfully uploaded item")
                                },
                                secondaryButton: .cancel()
                            )
                        case .second:
                            return Alert(
                                title: Text("Saknar information"),
                                message: Text("Skriv in i det tomma fältet"),
                                primaryButton: .default(Text("Fortsätt")) {
                                    print("missing information")
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
                .padding(10)
            }
        }
    }
}

struct CreateAdvertisementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAdvertisementView().environmentObject(AuthViewModel())
    }
}
