//
//  ContentView.swift
//  Reporizator
//
//  Created by Анохин Юрий on 06.11.2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("repo") private var repo = ""
    @Environment(\.openURL) var openURL
    @State private var showingOptions = false
    
    var body: some View {
        NavigationView {
            TextEditor(text: $repo)
                .navigationTitle("Reporizator")
                .padding()
                .keyboardType(.URL)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("Reporizator")
                            .resizable()
                            .frame(width: 32.0, height: 32.0)
                            .cornerRadius(5)
                    }
                }
        }
        Button(action: {
            showingOptions.toggle()
            hideKeyboard()
        }) {
            Text("Open In")
        }.buttonStyle(CustomButtonStyle())
            .padding()
            .confirmationDialog("Open In...", isPresented: $showingOptions, titleVisibility: .visible) {
                Button("Sileo") {
                    openURL(URL(string: "sileo://source/https://\(repo)")!)
                }
                
                Button("Cydia") {
                    openURL(URL(string: "cydia://url/https://cydia.saurik.com/api/share#?source=https://\(repo)")!)
                }
                
                Button("Zebra") {
                    openURL(URL(string: "zbra://sources/add/https://\(repo)")!)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
