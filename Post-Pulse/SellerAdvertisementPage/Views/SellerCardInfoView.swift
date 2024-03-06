//
//  SellerCardInfoView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-06.
//

import SwiftUI

struct SellerCardInfoView: View {
    
    let item: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 15, content: {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text("Säljare: \(item.user.employment)")
                    .font(.system(size: 14))
                    
                Text("\(item.user.nameOfUser)")
                    .fontWeight(.bold)
            })
            Spacer()
            VStack(alignment: .center, spacing: 10) {
                
                Text("\(item.user.phoneNumber)")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(10)
                
                Text("\(item.user.emailAddress)")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(10)
                 }
        })
        .padding(10)
    }
}

struct SellerCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SellerCardInfoView(item: Item(user: User(nameOfUser: "John Doe", phoneNumber: "123456789", emailAddress: "john@example.com", employment: "Företag"), name: " passat", image: ["passat sido"], description: "hej", price: "10", category: .fordon))
    }
}
