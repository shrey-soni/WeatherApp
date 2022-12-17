//
//  ApiConstants.swift
//  WeatherApp
//
//  Created by Shrey Soni on 15/12/22.
//

import Foundation

let baseUrl : String = "http://dataservice.accuweather.com/"


class Api{
    static let geoPositionSearch_Q = baseUrl+"locations/v1/cities/geoposition/search" // Q: latitude,longitude
    static let currentCondition_C = baseUrl+"currentconditions/v1/" // C: locationKey
    static let searchSuggestion_Q = baseUrl+"locations/v1/cities/autocomplete" // Q: searchString
}

// Legends:
// *_C : Change in absolute url is required
// *_Q : Query parameters are required
