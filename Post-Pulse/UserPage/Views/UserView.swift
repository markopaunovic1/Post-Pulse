//
//  UserView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-02-28.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        ZStack {
            Color(red: 194/255.0, green: 196/255.0, blue: 207/255.0)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                HStack(spacing: 20) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                    
                    Text("John Doe")
                        .fontWeight(.bold)
                }
                .frame(width: 350, height: 100)
                .background(Rectangle().fill((Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))))
                .cornerRadius(5)
                
                Divider()
                
                Button {
                    print("mina annonser")
                } label: {
                        Image(systemName: "pin.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 20)
                    
                        Text("Mina annonser")
                        .frame(width: 260, height: 100, alignment: .leading)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                }
                .background((Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0)))
                .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                .cornerRadius(5)
                
                Button {
                    print("Sparade favoriter")
                } label: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .accentColor(.red)
                            .padding(.leading, 20)
                    
                        Text("Sparade favoriter")
                        .frame(width: 260, height: 100, alignment: .leading)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                }
                .background((Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0)))
                .cornerRadius(5)

                    
                Spacer()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
