//
//  JokeNewView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct JokeNewView: View {
    let backgroundColor: Color
    let category: String
    @State var joke: String = ".. loading .."
    @State var firstAppear: Bool = true
    @ObservedObject var viewModel = JokeViewModel()

    var body: some View {
        VStack {
            if firstAppear{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
            }
            else {
                Text("\(joke)")
                .padding(50)
                .multilineTextAlignment(.center)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.black, lineWidth: 1)
                    )
                
                Button("Refresh ↝"){
                    Task{
                        await viewModel.setJoke(category: category)
                        joke = viewModel.joke
                    }
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
        .padding()
        .frame(width: 400, height: 700)
        .background(backgroundColor)
        .onAppear {
            if firstAppear{
                Task {
                    await viewModel.setJoke(category: category)
                    joke = viewModel.joke
                    firstAppear = false
                }
            }
        }
    }
}
