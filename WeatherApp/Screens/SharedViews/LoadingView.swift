//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Shrey Soni on 14/12/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
