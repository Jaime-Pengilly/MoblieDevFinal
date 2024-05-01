//
//  ContentView.swift
//  MoblieDevFinal
//
//  Created by PENGILLY, JAIME on 4/29/24.
//
//28b2645ca3540740ee85279d75572bb2
import SwiftUI
import Foundation
import Combine
struct Movie: Codable, Identifiable, Hashable {
    
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    
    init(id: Int, title: String, overview: String, poster_path: String, backdrop_path: String, vote_average: Double) {
        self.id = id
        self.title = title
        self.overview = overview
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.vote_average = vote_average
    }
}
//func getNowPlayingMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
//    guard let requestUrl = URL(string: url.absoluteString + "28b2645ca3540740ee85279d75572bb2") else {
//        return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
//    }
//    let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//    
//    return URLSession.shared.dataTaskPublisher(for: request)
//        .map({ $0.data })
//        .decode(type: MovieResults.self, decoder: JSONDecoder())
//        .map({ $0.results })
//        .eraseToAnyPublisher()
//}
func apicall() async throws -> Movie{
        guard let apiURL =
                URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=28b2645ca3540740ee85279d75572bb2") else{
            throw UserError.invalidURL
        }
        var request = URLRequest(url:apiURL)
        request.httpMethod = "GET"
        let (data, _) = try await URLSession.shared.data(for: request)
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        print(movie)
}
enum UserError: Error{
    case invalidURL
    case decodingFailed
}
struct ContentView: View {
    @State private var responseData: String = ""

    var body: some View {
        VStack {
            Text("Response: \(responseData)")
            Button("Fetch Data") {
                do {
                                        responseData = try await apicall()
                                    } catch {
                                        // Handle error
                                        print("Error: \(error)")
                                    }
                           }
                           // Call getNowPlayingMovies without a trailing closure

            }
        }
    }


#Preview {
    ContentView()
}


struct MovieResponse: Decodable {
    let results: [Movie]
}
