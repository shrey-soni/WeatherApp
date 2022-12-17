//
//  LocationKeyByCoordinatesViewModel.swift
//  WeatherApp
//
//  Created by Shrey Soni on 16/12/22.
//

import Foundation

class LocationKeyByCoordinatesViewModel:ObservableObject{
    @Published var model:LocationKeyByCoordinatesMode?
    func get(latitude:Double,longitude:Double){
        Task{
            let absoluteUrl = Api.geoPositionSearch_Q
            do{
                let result:LocationKeyByCoordinatesMode = try await NetworkManager().fetch(from: absoluteUrl,queryParams: [URLQueryItem(name: "q", value: "\(latitude),\(longitude)")])
                model=result
            }
            catch{
                print(error)
            }
        }
    }
}
