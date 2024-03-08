//
//  RegisterView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-08.
//

import SwiftUI

struct RegisterView: View {
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                //Background Image
                Image("LoginImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(1.0)
                
                VStack(alignment: .center) {
                    Image("PostPulseLogo")
                        .resizable()
                        .scaledToFit()
                        .padding(30)
                        .padding(.bottom, 150)
                    
                    // user inputs
                    Section {
                        TextField("Mejl:", text: $email)
                        TextField("Lösenord:", text: $password)
                    }
                    .padding(5)
                    .padding(.leading, 8)
                    .autocapitalization(.none)
                    .font(.system(size: 20))
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(25)
                    .frame(width: 280)
                    
                    .padding(.bottom, 20)
                    // sign in button
                    Button {
                        print("Log user in")
                    } label: {
                        Text("LOGGA IN")
                            .frame(width: 230, height: 45)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .background(Color(red: 28/255, green: 47/255, blue: 89/255))
                    .cornerRadius(10)
                    .padding(4)
                    
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(email: .constant(""), password: .constant(""))
    }
}
