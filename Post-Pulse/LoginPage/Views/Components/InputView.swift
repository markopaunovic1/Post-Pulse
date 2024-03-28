
import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(Color.white.opacity(0.8))
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.leading, 13)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding(5)
                    .padding(.leading, 7)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .frame(width: 280)
            } else {
                TextField(placeholder, text: $text)
                    .padding(5)
                    .padding(.leading, 7)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(25)
                    .frame(width: 280)
            }
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
