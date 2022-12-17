//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager:LocationManager
    var body: some View {
        VStack{
            VStack{
                Text("Welcome to weather app")
                    .bold().font(.title)
                Text("Please give permission")
                    .padding()
            }.multilineTextAlignment(.center)
                .padding()
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
