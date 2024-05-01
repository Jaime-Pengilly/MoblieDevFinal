//
//  API STUFF.swift
//  MoblieDevFinal
//
//  Created by PENGILLY, JAIME on 4/30/24.
//

import Foundation
import Combine

/// Enum that stores API information
enum APIInformation: String {
    case key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
}

protocol DataServicing {
    func getNowPlayingMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error>
}
    
class APICaller: DataServicing {
    
    let apiKey = APIInformation.key
    /// Protocol for DataServicing
    func getNowPlayingMovies(toUrl url: URL) -> AnyPublisher<[Movie], Error> {
        guard let requestUrl = URL(string: url.absoluteString + apiKey.rawValue) else {
            return Fail(error: NSError(domain: "Invalid url", code: 0)).eraseToAnyPublisher()
        }
        let request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .map({ $0.results })
            .eraseToAnyPublisher()
    }
}
