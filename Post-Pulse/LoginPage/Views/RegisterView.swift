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
    @State private var employment = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var authViewModel: AuthViewModel
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
                            .padding(.bottom, 50)
                        
                        InputView(text: $email, title: "Mejl:", placeholder: "namn@exempel.se")
                            .autocapitalization(.none)
                        
                        InputView(text: $fullname, title: "Fullständiga namn:", placeholder: "John Doe")
                        
                        InputView(text: $employment, title: "Privat eller Företag:", placeholder: "Företag etc")
                        
                        InputView(text: $phoneNumber, title: "Telefon nummer:", placeholder: "076...")
                        
                        InputView(text: $password, title: "Lösenord:", placeholder: "Skriv in lösenord", isSecureField: true)
                        
                        ZStack(alignment: .trailing) {
                            InputView(text: $confirmPassword, title: "Bekräfta lösenord:", placeholder: "Skriv in lösenord", isSecureField: true)
                            
                            if !password.isEmpty && !confirmPassword.isEmpty {
                                if password == confirmPassword {
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width: 15, height: 15)
                                        .padding(.trailing, 10)
                                        .padding(.top, 20)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.green)
                                } else {
                                    Image(systemName: "xmark.circle.fill")
                                        .frame(width: 15, height: 15)
                                        .padding(.trailing, 10)
                                        .padding(.top, 20)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.red)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Button {
                        Task {
                            try await authViewModel.createUser(withEmail: email, password: password, fullname: fullname, employment: employment, phoneNumber: phoneNumber)
                        }

                    } label: {
                        Text("SKAPA KONTO")
                            .frame(width: 230, height: 45)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .background(Color(red: 28/255, green: 47/255, blue: 89/255))
                    .disabled(!inputIsValid)
                    .opacity(inputIsValid ? 1.0 : 0.5)
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

// AuthenticationFormProtocol
extension RegisterView: AuthenticationFormProtocol {
    var inputIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
