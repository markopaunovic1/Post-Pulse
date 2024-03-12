//
//  pathView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-11.
//

import SwiftUI

struct pathView: View {
    
    let imageName: String
    let pathName: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor((Color(red: 28/255.0, green: 47/255.0, blue: 89/255.0)))
                .padding(.leading, 15)
                
            Text(pathName)
                .font(.system(size: 20))
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: 360, height: 70)
        .background((Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0)))
        .cornerRadius(5)
        .shadow(color: .gray, radius: 6, x: 3, y: 4)
    }
}

struct pathView_Previews: PreviewProvider {
    static var previews: some View {
        pathView(imageName: "list.triangle", pathName: "Mina favoriter")
    }
}
