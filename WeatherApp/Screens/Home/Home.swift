//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shrey Soni on 13/12/22.
//

import SwiftUI
import _CoreLocationUI_SwiftUI

struct HomeView: View {
    @StateObject var locationManager=LocationManager()
    
    var body: some View {
        VStack{
            if let location = locationManager.location{
                LocationKeyByCoordinates(latitude: location.latitude, longitude: location.longitude)
            }
            else{
                if locationManager.isLoading{
                    ProgressView()
                }
                else{
                    WelcomeView().environmentObject(locationManager)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
