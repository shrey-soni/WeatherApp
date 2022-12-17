//
//  DetailPage.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import SwiftUI

struct DetailPage: View {
    let locationName,locationKey:String
    
    @ObservedObject var detailPageViewModel = DetailPageViewModel()
    @State var showLocationSearchSheet = false
    
    init(locationName: String, locationKey: String) {
        self.locationName = locationName
        self.locationKey = locationKey
        fetchWeatherConditions(locationKey: locationKey)
    }
    
    func changeLocation(){
        showLocationSearchSheet.toggle()
    }
    
    func onRefresh(){}
    
    func fetchWeatherConditions(locationKey:String){
        detailPageViewModel.getDetailsForLocationKey(locationKey: locationKey)
    }
    
    var body: some View {
        if(detailPageViewModel.detailPageModel == nil){
            ProgressView()
        }else{
            NavigationView(content: {
                VStack{
                    ScrollView{
                        HStack{
                            Text("Weather type: ")
                            Spacer()
                            Text(detailPageViewModel.detailPageModel!.WeatherText)
                                .bold()
                        }.padding()
                        HStack{
                            Text("Temprature: ")
                            Spacer()
                            Text(String(detailPageViewModel.detailPageModel!.Temperature.Metric.Value))
                                .bold()
                            Text("°"+detailPageViewModel.detailPageModel!.Temperature.Metric.Unit)
                                .bold()
                        }.padding()
                        Spacer()
                    }
                }
                .navigationTitle(locationName)
                    .toolbar{
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button {
                                showLocationSearchSheet.toggle()
                            } label: {
                                Label("Search Location", systemImage: "magnifyingglass.circle")
                            }
                            .sheet(isPresented: $showLocationSearchSheet){
                                SearchLocationSheet()
                            }
                        }
                    }
            }).refreshable {
                onRefresh()
            }
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(locationName:"Nagpur",locationKey:"")
    }
}
