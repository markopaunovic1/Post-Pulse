//
//  GridImageView.swift
//  Post-Pulse
//
//  Created by Marko Paunovic on 2024-03-05.
//

import SwiftUI

struct GridImageView: View {
    
    @EnvironmentObject var theItem: ItemViewModel
    let numberOfImagesToShow = 4
        
        let index: Int
        let imageName: String
        let item: Item
        
        init(index: Int, imageName: String, item: Item) {
            self.index = index
            self.imageName = imageName
            self.item = item
        }
    
    var body: some View {
        ZStack {
            ForEach(item.image, id: \.self) { image in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (getRect().width - 20) / 2, height: 120)
            }
        }
            if imageName.count > 4 && index == 3 {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.black.opacity(0.5))
                
                let remainingImages = index
                Text("+\(remainingImages)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
            }
        }
    }


struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
        GridImageView(index: 1, imageName: "passat rear", item: Item.init(name: "passat 2016", image: ["passat interior", "passat sido"], description: "fin", price: "10", category: .fordon))
    }
}

extension View {
  func getRect() -> CGRect {
    
      return UIScreen.main.bounds
  }
}
