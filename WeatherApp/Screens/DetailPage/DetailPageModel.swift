//
//  DetailPageModel.swift
//  WeatherApp
//
//  Created by Shrey Soni on 15/12/22.
//

import Foundation

struct DetailPageModel:Codable {
    let WeatherText: String
    let WeatherIcon: Int
    let IsDayTime: Bool
    let Temperature: Temperature
}

struct Temperature:Codable {
    let Metric, Imperial: Imperial
}

struct Imperial:Codable {
    let Value: Double
    let Unit: String
    let UnitType: Int
}

