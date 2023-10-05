import SwiftUI

class JokeViewModel: ObservableObject {
    @Published var joke: String = " .. loading .."

    func fetchJoke(category: String) async {
        joke = await getRandomJoke(category: category) ?? ""
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
}
