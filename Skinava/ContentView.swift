//
//  ContentView.swift
//  Skinava
//
//  Created by Akila Varadarajan on 2/27/21.
//

import SwiftUI

struct NavigationIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARView
    func makeUIViewController(context: Context) -> ARView {
        return ARView()
    }
    func updateUIViewController(_ uiViewController:
                                    NavigationIndicator.UIViewControllerType, context:
                                        UIViewControllerRepresentableContext<NavigationIndicator>) { }
}

struct ContentView: View {
    @State var page = "History"
    var body: some View {
        NavigationView {
            ZStack {
                NavigationIndicator()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                VStack {
                    Spacer()
                    Spacer()
                    NavigationLink(destination: HistoryView()) {
                        Text("Skin History")
                            .foregroundColor(Color.purple)
                            .padding()
                            
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.white).opacity(0.7))
                            .padding(.bottom)
                    }
                    
                }
            }
        } 
    }
}


