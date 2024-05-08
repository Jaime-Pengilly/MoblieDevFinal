import SwiftUI
import Foundation

struct MovieCard: View {
    @Environment(\.dismiss) var dismiss
    @Binding var movie: Movie
    var body: some View {
        VStack {
            Text("Movie Details")
                .font(.largeTitle)
            if let posterPath = movie.poster_path {
                Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No poster available")
            }
            Text(movie.title)
                .font(.title)
            Text(movie.overview)
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Text("Done")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
