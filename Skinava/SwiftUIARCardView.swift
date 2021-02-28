//
//  SwiftUIARCardView.swift
//  Skinava
//
//  Created by Sanchitha Dinesh on 2/27/21.
//

import SwiftUI

import SwiftUI

struct SwiftUIARCardView: View {
    @State private var textToShow = "Keratosis Pilaris"
    var body: some View {
            VStack {
                Text(textToShow)
                    .foregroundColor(.white)
                    .bold().font(.title)
                Button(action: {
                    self.textToShow = "Tap for more info"
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(width: 150, height: 50)
                        Text("Tap for more info")
                            .foregroundColor(Color.purple)
                    }
                }
            }
        
    }
}

struct SwiftUIARCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIARCardView()
    }
}
