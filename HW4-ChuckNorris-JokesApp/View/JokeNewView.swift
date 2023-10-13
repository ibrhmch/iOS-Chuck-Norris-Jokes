//
//  JokeNewView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI
import NotificationCenter

struct JokeNewView: View {
    let backgroundColor: Color
    let category: String
    @State var joke: String = ".. loading .."
    @State var firstAppear: Bool = true
    var viewModel: JokeViewModel
    var pushNotificationService = PushNotificationService()
    
    init(backgroundColor: Color, category: String){
        self.backgroundColor = backgroundColor
        self.category = category
        self.viewModel = JokeViewModel(category: self.category)
    }

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
                        firstAppear = true
                        viewModel.setJoke(category)
                        joke = viewModel.joke
                        firstAppear = false
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
                
                Button("Remind me about this country.") {
                    pushNotificationService.requestPermissions()
                    
                    pushNotificationService.scheduleNotification(
                        title: "your joke reminder",
                        subtitle: "\(joke)"
                    )
                }
                .padding(12)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.black, lineWidth: 1)
                    )
                .offset(y:120)
                
            }
        }
        .padding()
        .frame(width: 400, height: 700)
        .background(backgroundColor)
        .task {
            if firstAppear{
                    joke = viewModel.joke
                    firstAppear = false
            }
        }
    }
}
