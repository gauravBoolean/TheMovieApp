//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by superoot on 26/12/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import Alamofire

let baseUrl = "https://api.themoviedb.org/3/"
let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"

enum ServicePathLocator : String {
    case trending = "trending"
    case search = "search/movie"
    
    
    func getUrl(with args : [String]) -> URL{
        switch self {
        case .trending:
            let params_str = args.reduce("", {res , str in
                res + "/" + str
            })
            let url_str = baseUrl + self.rawValue + params_str
            return URL(string: url_str)!
        case .search:
            return URL(string: baseUrl + self.rawValue)!
        }
    }
}

class NetworkManager{
    
}


func excuteRESTService<T : Codable>(type : T.Type , _ method: Alamofire.HTTPMethod, serviceUrl : URL, param:[String: AnyObject]?, headers:[String : String]?  = nil, completion: @escaping (T? , ErrorResponse? , Int?) -> ()) -> Void{
    
    
    OperationQueue.main.addOperation({
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    })
    
    var parameter = [String: AnyObject]()
    if param != nil{
        parameter = param!
    }
    let inferType = type
    
    var paramEncoding: ParameterEncoding {
        
        if method == .get {
            return URLEncoding.default
        }
        else {
            
            return JSONEncoding.default
        }
    }
    
    var reqHeaders = [String : String]()
    
    if headers != nil {
        
        reqHeaders = headers!
    }
    
    let networkQueue = DispatchQueue.global(qos: .userInitiated)
    
    Alamofire.request(serviceUrl, method: method, parameters: parameter, encoding: paramEncoding, headers: reqHeaders).debugLog().response(queue: networkQueue, responseSerializer:DataRequest.jsonResponseSerializer(options: .allowFragments), completionHandler: {
        response in
        
        print("Status Code - \(String(describing: response.response?.statusCode))")
        
        OperationQueue.main.addOperation({
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        
        guard let data = response.data else {
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
//        guard let decodedResult  = try? jsonDecoder.decode(inferType, from: data) else {
//            return
//        }
        
        do{
            let decodedResult  = try jsonDecoder.decode(inferType, from: data)
            print(decodedResult)
            completion(decodedResult, nil , nil)
        }
        catch {
            print("\(error)")
        }
        
        
        return
        
    })
}

func loadImageData(urlString : String ,  successCompletionBlock : @escaping (UIImage)->()){
    Alamofire.request(urlString).responseData{
        response in
        if let data  = response.result.value , let img = UIImage(data: data){
            successCompletionBlock(img)
        }
    }
}



struct TrendingMovies: Codable {
    let page: Int?
    let results: [Movie]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview, posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let popularity: Double?
    let firstAirDate, name: String?
    let originCountry: [String]?
    let originalName: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}


extension Request {
    public func debugLog() -> Self {
        debugPrint(self)
        
        return self
    }
}




struct ErrorResponse: Codable {
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
