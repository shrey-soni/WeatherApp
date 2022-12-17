//
//  LocalStorage.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import Foundation

class LocalStorage{
    var userDefaults=UserDefaults.standard
    
    func getStoredValue(key:String) -> Any? {
        if( userDefaults.object(forKey: key) != nil ){
            return userDefaults.value(forKey: key)
        }
        else{
            return nil
        }
    }
    
    func setStoragePair(key:String, val:Any?) {
        userDefaults.set(val, forKey: key)
    }
    
    func deleteStorageKey(key:String){
        userDefaults.removeObject(forKey: key)
    }
}

