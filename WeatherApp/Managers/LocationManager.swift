//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let localStorage = LocalStorage()

    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading=false
    
    override init() {
        super.init()
        manager.delegate = self
        previouslyDeterminedLocation()
    }

    func requestLocation() {
        manager.requestLocation()
    }
    
    func previouslyDeterminedLocation(){
        if let storageValue = localStorage.getStoredValue(key: StorageKeys.userLocation) as? Array<Double> {
            location = CLLocationCoordinate2D(latitude: storageValue[0], longitude: storageValue[1])
        }
    }
    
    private func setLocationToLocalStorage(){
        localStorage.deleteStorageKey(key: StorageKeys.userLocation)
        localStorage.setStoragePair(key: StorageKeys.userLocation, val: [location?.latitude,location?.longitude])
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading=true
        setLocationToLocalStorage()
    }
    
//    private func fallbackToNagpur(){
//        location = CLLocationCoordinate2D(latitude: Constants.nagpurLatitude, longitude: Constants.nagpurLongitude)
//        setLocationToLocalStorage()
//        print("Fallback coordinate Nagpur is set.")
//        print("Latitude: \(location?.latitude ?? Constants.nagpurLatitude)")
//        print("Longitude: \(location?.longitude ?? Constants.nagpurLongitude)")
//    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting the location:\(error)")
    }
}
