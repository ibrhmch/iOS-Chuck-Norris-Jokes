//
//  JokeNewView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct JokeNewView: View {
    @Binding var backgroundColor: Color
    @Binding var category: String
    @ObservedObject var viewModel = JokeViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.joke)")
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
                    let newJoke = await getRandomJoke(category: category)
                    viewModel.joke = (newJoke ?? viewModel.joke)!
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
        .padding()
        .frame(width: 400, height: 700)
        .background(backgroundColor)
        .onAppear {
            Task {
                await viewModel.fetchJoke(category: category)
                viewModel.joke = viewModel.joke
            }
        }
    }
}
