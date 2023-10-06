import SwiftUI

class JokeViewModel {
    var joke: String = " .. loading .."
    
    init (category: String){
        setJoke(category)
    }
    
    func setJoke(_ category: String) {
        Task{
            joke = await getRandomJoke(category: category) ?? ""
        }
    }
    
    private func getRandomJoke(category: String = "travel") async -> String? {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random?category=\(category)")!)
            let joke = try JSONDecoder().decode(Joke.self, from: data)
            return joke.value
        } catch {
            return nil
        }
    }
}
