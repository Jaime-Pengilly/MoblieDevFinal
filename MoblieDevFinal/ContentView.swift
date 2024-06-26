//
//  ContentView.swift
//  MoblieDevFinal
//
//  Created by PENGILLY, JAIME on 4/29/24.
//
//

import SwiftUI
import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct ContentView: View {
    @State var movies: [Movie] = []
    @State var selectedMovie = Movie(id: 43543, title: "", overview: "", poster_path: "", backdrop_path: "", vote_average: 0.03)
    @State var showMovieCard = false

    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack {
                List(movies) { movie in
                    VStack{
                        if let backdropPath = movie.backdrop_path {
                            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
                            if let imageData = try? Data(contentsOf: imageURL!) {
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        selectedMovie = movie.self
                                        print(selectedMovie)
                                        showMovieCard.toggle()
                                    }
                                
                            } else {
                                Text("Image not found")
                            }
                        } else {
                            Text("No image available")
                        }
                        HStack{
                            Text(movie.title)
                            Text("\(String(format:"%.02f", movie.vote_average*10))")
                        }.foregroundStyle(Color.white)
                    }.listRowBackground(Color.black)
                }.background(Color.black)
                    Button("Fetch Data") {
                        fetchData()
                    }
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(600)
            
                
            }
            .sheet(isPresented: $showMovieCard){
                MovieCard(movie: $selectedMovie)
                
            }
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data returned: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    self.movies = movieResponse.results
                    print(self.movies)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
