//
//  ContentView.swift
//  MoblieDevFinal
//
//  Created by PENGILLY, JAIME on 4/29/24.
//
//28b2645ca3540740ee85279d75572bb2
import SwiftUI
import Foundation
struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let voteCount: Int
}

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                ScrollView {
                    ForEach(movies, id: \.id) { movie in
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.title)
                                .padding(.bottom, 4)
                            
                            Text(movie.overview)
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            Text("Release Date: \(movie.releaseDate)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 4)
                            
                            HStack {
                                Spacer()
                                Text("Average Rating: \(movie.voteAverage)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Vote Count: \(movie.voteCount)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            // Fetch movie data when the view appears
            fetchData()
        }
    }

    private func fetchData() {
        // Define the query items
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]

        // Construct the URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/now_playing"
        components.queryItems = queryItems

        guard let url = components.url else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer 28b2645ca3540740ee85279d75572bb2"
        ]

        // Simulating asynchronous network call by using DispatchQueue
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Replace this with your actual network call
            let mockData = """
            {
                "results": [
                    {
                        "id": 502356,
                        "title": "The Super Mario Bros. Movie",
                        "overview": "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
                        "release_date": "2023-04-05",
                        "vote_average": 7.5,
                        "vote_count": 1456
                        // Other movie objects here...
                    }
                ]
            }
            """
            let jsonData = Data(mockData.utf8)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: jsonData)
                self.movies = response.results
                self.isLoading = false
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
