//
//  SearchLocation.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import SwiftUI

struct SearchLocationSheet: View {
    @State var searchedString:String=""
    
    @ObservedObject var searchLocationVM=SearchLocationViewModel()
    
    func onSearchkeywordChange(newValue:String){
        searchLocationVM.search(keyword: newValue)
    }
    
    func locationItem(location:SearchedLocationModel)->some View{
        return ZStack(alignment: .leading){
            Rectangle()
                .frame(height: 70)
                .foregroundColor(.gray)
            Text(location.LocalizedName)
                .padding()
                .font(.title)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            print(location.LocalizedName+"  tapped")
        }
    }
    
    func searchedLocationHistory()->some View{
        return VStack{
            Text("History")
                .bold().font(.title)
                .padding(.bottom)
            HStack{
                VStack(alignment: .leading){
                    ForEach(searchLocationVM.previouslySearchedLocation ?? [] ,id: \.Key){location in
                        locationItem(location:location)
                    }
                }.padding()
                Spacer()
            }.padding()
            Spacer()
        }
    }
    
    func searchSuggestions()->some View{
        return List(searchLocationVM.searchSuggestions ?? [] , id: \.Key){ location in
            Text(location.LocalizedName)
                .onTapGesture {
                    searchLocationVM.addNewItemToSearchHistory(item: location)
                }
        }
    }
    
    var body: some View {
        NavigationView(content: {
            ScrollView{
                VStack(spacing: 30){
                    if(searchLocationVM.searchSuggestions != nil){
                        searchSuggestions()
                    }
                    if(searchLocationVM.previouslySearchedLocation != nil){
                        searchedLocationHistory()
                    }
                }
            }
        })
        .searchable(text: $searchedString,placement: .automatic,prompt: "Search new location..")
        .onChange(of: searchedString){newValue in
            onSearchkeywordChange(newValue: newValue)
        }
    }
}

struct ChangeLocationSheet_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationSheet()
    }
}
