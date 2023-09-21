//
//  ContentView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct ContentView: View {
    @State var name: String = "John"
    @State var showHello: Bool = false
    @State var backgroundColor: Color = Color.white
    
    var body: some View {
        TabView {
            CategoriesView(backgroundColor: $backgroundColor)
                .tabItem{
                    Label("Jokes", systemImage: "house")
            }
            Settings(backgroundColor: $backgroundColor)
                .tabItem{
                    Label("Settings",
                    systemImage: "gearshape")
                    }

        }
    }
}

struct CategoriesView: View {
    @Binding var backgroundColor: Color
    @State var categories: [String] = ["sport", "fashion"]
    @State var isLoading: Bool = true
    
    
    func getChuckJokesCategories() async -> () {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/categories")!)
            categories = try JSONDecoder().decode([String].self, from: data)
        } catch {
            categories = ["sport", "fashion"]
        }
        isLoading = false
    }
    
    var body: some View{
        NavigationStack {
            if isLoading{
                Text(".. loading ..")
            } else {
                List(categories, id: \.self) { item in
                    NavigationLink(destination: JokeView(backgroundColor: $backgroundColor, category: .constant(item))) {
                        Text("\(item)")
                    }
                }
                .navigationBarTitle("Joke Categories")
            }
        }
        .background(backgroundColor)
        .task {
            await getChuckJokesCategories()
        }
    }
}

struct Joke: Codable {
    let icon_url: String
    let id: String
    let url: String
    let value: String
}


func getRandomJoke(category: String = "travel") async -> String? {
    do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random?category=\(category)")!)
        let joke = try JSONDecoder().decode(Joke.self, from: data)
        return joke.value
    } catch {
        return nil
    }
}

struct JokeView: View {
    @Binding var backgroundColor: Color
    @Binding var category: String
    @State var value: String = " .. loading .."
    
    var body: some View {
        VStack {
            Text("\(value)")
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
                    value = (newJoke ?? value)!
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
                let newJoke = await getRandomJoke(category: category)
                value = (newJoke ?? value)!
            }
        }
    }

}

struct DetailView: View {
    @Binding var backgroundColor: Color
    var body: some View {
        VStack{
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

struct Settings: View {
    @Binding var backgroundColor: Color
    @State var showingSheet = false
    
    var body: some View{
        NavigationStack{
            VStack{
                NavigationLink("Customize the App") {
                    DetailView(backgroundColor: $backgroundColor)
                }
                .frame(width: 400, height: 50)
                .background(Color.black)
                .foregroundColor(Color.white)
                
                Button("Reset all Settings"){
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

func randomColor() -> Color {
    return Color(
        red: Double.random(in: 0.8...1),
        green: Double.random(in: 0.8...1),
        blue: Double.random(in: 0.8...1)
    )
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
