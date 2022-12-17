//
//  DetailPageViewModel.swift
//  WeatherApp
//
//  Created by Shrey Soni on 15/12/22.
//

import Foundation

class DetailPageViewModel:ObservableObject{
    @Published var detailPageModel:DetailPageModel?
    
    func getDetailsForLocationKey(locationKey:String){
        Task{
            let absoluteUrl = Api.currentCondition_C + locationKey
            do{
                let result:[DetailPageModel] = try await NetworkManager().fetch(from: absoluteUrl,queryParams: nil)
                detailPageModel=result.first
            }
            catch{
                print(error)
            }
        }
    }
}
