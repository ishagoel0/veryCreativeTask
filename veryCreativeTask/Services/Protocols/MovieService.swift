//
//  MovieService.swift
//  veryCreativeTask
//
//  Created by Isha Goel on 17/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: Endpoint, params: [String: String]?, successHandler: @escaping (_ response: MoviesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchMovie(id: Int, successHandler: @escaping (_ response: Movie) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}


public enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
    case favourite
    
    public var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .favourite: return "Favourite"
        }
    }
    

    public init?(index: Int) {
        switch index {
        case 0: self = .nowPlaying
        case 1: self = .popular
        case 2: self = .upcoming
        case 3: self = .topRated
        case 4: self = .favourite
        default: return nil
        }
    }
    
    public init?(description: String) {
        guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
    
}

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
