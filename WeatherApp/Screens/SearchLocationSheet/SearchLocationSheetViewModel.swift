//
//  ChangeLocationSheetViewModel.swift
//  WeatherApp
//
//  Created by Shrey Soni on 15/12/22.
//

import Foundation

class SearchLocationViewModel:ObservableObject{
    @Published var previouslySearchedLocation:[SearchedLocationModel]?
    @Published var searchSuggestions:[SearchedLocationModel]?
    
    let localStorage=LocalStorage()
    
    init() {
        setPreviouslySearchedLocations()
    }
    
    private func setPreviouslySearchedLocations(){
        previouslySearchedLocation = getUpdatedSearchHistoryModelList(list: getSearchHistory())
    }
    
    func search(keyword:String){
        if(keyword == ""){
            searchSuggestions=nil;
            return
        }
        
        Task{
            let absoluteUrl = Api.searchSuggestion_Q
            do{
                let result:[SearchedLocationModel] = try await NetworkManager().fetch(from: absoluteUrl,queryParams: [URLQueryItem(name: "q", value: keyword)])
                if(result.count<=5){
                    searchSuggestions=result
                }
                else{
                    searchSuggestions=result.dropLast(result.count-5)
                }
                
            }
            catch{
                print(error)
            }
        }
    }
    
    private func getSearchHistory()->[[String]]{
        if let list = localStorage.getStoredValue(key: StorageKeys.previousSearchedLocations) as? [[String]]{
            return list
        }else{
            return []
        }
    }
    
    private func deleteSearchHistory(){
        localStorage.deleteStorageKey(key: StorageKeys.previousSearchedLocations)
    }
    
    private func getUpdatedSearchHistoryModelList(list:[[String]])->[SearchedLocationModel]{
        var ret:[SearchedLocationModel]=[]
        for item in list {
            ret.append(SearchedLocationModel(Key: item[0], LocalizedName: item[1]))
        }
        return ret
    }
    
    func addNewItemToSearchHistory(item:SearchedLocationModel){
        var list = getSearchHistory()
        for i in list {
            if(i[0]==item.Key){
                return
            }
        }
        let itemKey=item.Key,itemName=item.LocalizedName
        list.append([itemKey,itemName])
        deleteSearchHistory()
        localStorage.setStoragePair(key: StorageKeys.previousSearchedLocations, val: list)
        previouslySearchedLocation = getUpdatedSearchHistoryModelList(list: list)
    }
}
