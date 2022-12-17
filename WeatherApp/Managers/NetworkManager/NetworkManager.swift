//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import Foundation

struct NetworkManager {
    private func getUrlStringWithQueryParams(urlString:String, newParams: [URLQueryItem]?)->String{
        let apiKeyQI = URLQueryItem(name: "apikey", value: Constants.apiKey)
        if let url = URL.init(string: urlString){
            var urlComponents = NSURLComponents.init(url: url, resolvingAgainstBaseURL: false)
            guard urlComponents != nil else { return ""; }
            if (urlComponents?.queryItems == nil) {
                urlComponents!.queryItems = [];
            }
            if(newParams == nil){
                urlComponents?.queryItems!.append(contentsOf: [apiKeyQI]);
            }
            else{
                urlComponents?.queryItems!.append(contentsOf: [apiKeyQI]+(newParams ?? []));
            }
            return urlComponents?.url?.absoluteString ?? "";
        }
        return ""
    }
    
    func fetch<T: Codable>(from urlString: String, queryParams:[URLQueryItem]?) async throws -> T {
        
        
        guard let url = URL(string: getUrlStringWithQueryParams(urlString: urlString, newParams: queryParams)) else  {
            throw URLError(.badURL)
        }
        print("\n\nFetching::\(url.absoluteString)\n\n")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Bad Server Response")
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        
        return result
    }
}
