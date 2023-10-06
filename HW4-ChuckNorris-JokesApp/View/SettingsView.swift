//
//  SettingsView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/5/23.
//

import SwiftUI

struct Settings: View {
    @Binding var backgroundColor: Color
    @Binding var explicitAllowed: Bool
    @State var showingSheet = false
    
    var body: some View{
        NavigationStack{
            VStack{
                NavigationLink("Customize the App") {
                    DetailView(backgroundColor: $backgroundColor,
                               explicitAllowed: $explicitAllowed)
                }
                .frame(width: 400, height: 50)
                .background(Color.black)
                .foregroundColor(Color.white)
                
                Button("Reset the color"){
                    showingSheet = true
                }
                .frame(width: 400, height: 50)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .sheet (isPresented: $showingSheet) {
                    SheetView(backgroundColor: $backgroundColor)
                }
                
            }
            .position(x:180, y:100)
            .padding()
            .navigationTitle("Settings")
            .background(backgroundColor)
        }
    }
}

struct DetailView: View {
    @Binding var backgroundColor: Color
    @Binding var explicitAllowed: Bool
    
    var body: some View {
        VStack{
            Toggle("Explicit Category", isOn: $explicitAllowed)
            
            Button("Randomize the background color ↝"){
                backgroundColor = randomColor()
                // Call the function using an async task
            }
            .padding(20)
            .background(Color.indigo)
            .foregroundColor(Color.white)
            .cornerRadius(7)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.black, lineWidth: 1)
                )
            .offset(y:100)
        }
        .padding()
        .frame(width: 400, height: 700)
        .background(backgroundColor)
    }
}

struct SheetView: View {
    @Environment (\.dismiss) var dismiss
    @Binding var backgroundColor: Color
    var body: some View {
        Button ("Press to Reset Color") {
            backgroundColor = Color.white
            dismiss()
        }
        .padding(20)
        .background(Color.indigo)
        .foregroundColor(Color.white)
        .cornerRadius(7)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.black, lineWidth: 1)
            )
        .offset(y:100)
    }
}
