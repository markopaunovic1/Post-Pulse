//
//  RegisterView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-08.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
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
                
                VStack {
                    VStack(alignment: .center) {
                        Image("PostPulseLogo")
                            .resizable()
                            .scaledToFit()
                            .padding(30)
                            .padding(.bottom, 150)
                        
                        InputView(text: $email, title: "Mejl:", placeholder: "namn@exempel.se")
                            .autocapitalization(.none)
                        
                        InputView(text: $fullname, title: "Fullständiga namn:", placeholder: "John Doe")
                        
                        InputView(text: $password, title: "Lösenord:", placeholder: "Skriv in lösenord", isSecureField: true)
                        
                        InputView(text: $confirmPassword, title: "Bekräfta lösenord:", placeholder: "Skriv in lösenord", isSecureField: true)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        print("Signing up user...")
                            dismiss()

                    } label: {
                        Text("SKAPA KONTO")
                            .frame(width: 230, height: 45)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .background(Color(red: 28/255, green: 47/255, blue: 89/255))
                    .cornerRadius(10)
                    .padding(4)
                    .padding(.top, 20)
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack(spacing: 5) {
                            Text("Har du redan ett konto?")
                                .foregroundColor(.white)
                            Text("Logga in")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .font(.system(size: 14))
                    }
                    Spacer()
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
