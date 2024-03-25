//
//  SellerCardInfoView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-06.
//

import SwiftUI

struct SellerCardInfoView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var user: User2
    
    var body: some View {

            HStack(alignment: .center, spacing: 15, content: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(red: 20/255.0, green: 33/255.0, blue: 61/255.0))
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Säljare: \(user.employment)")
                        .font(.system(size: 14))
                    
                    Text("\(user.fullname)")
                        .fontWeight(.bold)
                })
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    
                    Text("\(user.phoneNumber)")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Text("\(user.email)")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            })
            .padding(10)
            .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 6, x: 3, y: 4)
        }
    
}

struct SellerCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
