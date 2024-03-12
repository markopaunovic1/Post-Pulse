//
//  UserView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            ZStack {
                Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0)
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 20) {
                    HStack(spacing: 20) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                        
                        VStack(alignment: .leading) {
                            Text(user.fullname)
                                .fontWeight(.bold)
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 350, height: 70)
                    .background(Rectangle().fill((Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))))
                    .cornerRadius(5)
                    
                    Divider()
                    
                    Section {
                        Button {
                            print("mina annonser")
                        } label: {
                            pathView(imageName: "list.triangle", pathName: "Mina annonser")
                        }
                        
                        Button {
                            print("sparade favoriter")
                        } label: {
                            pathView(imageName: "heart.fill", pathName: "Sparade favoriter")
                        }
                        Spacer()
                        Button {
                            authViewModel.signOut()
                        } label: {
                            pathView(imageName: "rectangle.portrait.and.arrow.right", pathName: "Logga ut")
                                .foregroundColor(.red)
                                .padding(.bottom, 30)
                                
                        }
                    }
                    .accentColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))

                }
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView().environmentObject(AuthViewModel())
    }
}
