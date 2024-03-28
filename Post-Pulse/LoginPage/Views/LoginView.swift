
import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack {
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
                        VStack(spacing: 24) {
                            InputView(text: $email, title: "Mejl:", placeholder: "namn@exempel.se")
                                .autocapitalization(.none)
                            
                            InputView(text: $password, title: "Lösenord:", placeholder: "Skriv in lösenord", isSecureField: true)
                        }
                        
                        // sign in button
                        Button {
                            Task {
                                try await authViewModel.signIn(withEmail: email, password: password)
                            }
                        } label: {
                            Text("LOGGA IN")
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
                        
                        // sign up Button
                        NavigationLink {
                            RegisterView()
                        } label: {
                            HStack(spacing: 5) {
                                Text("Har du inget konto?")
                                    .foregroundColor(.white)
                                Text("Skapa konto")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .font(.system(size: 14))
                        }
                    }
                }
            }
        }
    }
}

// AuthenticationFormProtocol
extension LoginView: AuthenticationFormProtocol {
    var inputIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
