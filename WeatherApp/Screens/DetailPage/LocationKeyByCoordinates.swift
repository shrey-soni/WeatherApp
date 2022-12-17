//
//  DetailPageWrapper.swift
//  WeatherApp
//
//  Created by Shrey Soni on 16/12/22.
//

import SwiftUI

struct LocationKeyByCoordinates: View {
    let latitude,longitude:Double
    
    @ObservedObject var locationModel=LocationKeyByCoordinatesViewModel()
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        locationModel.get(latitude: latitude, longitude: longitude)
    }
    
    var body: some View {
        if(locationModel.model == nil){
            ProgressView()
        }else{
            DetailPage(locationName:locationModel.model?.EnglishName ?? "Nagpur", locationKey:locationModel.model?.Key ?? "204844")
        }
        
    }
}

struct LocationKeyByCoordinates_Previews: PreviewProvider {
    static var previews: some View {
        LocationKeyByCoordinates(latitude: Constants.nagpurLatitude, longitude: Constants.nagpurLongitude)
    }
}
