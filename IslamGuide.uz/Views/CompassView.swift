//
//  CompassView.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//

import SwiftUI

struct CompassView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Text("Heading: \(locationManager.currentHeading, specifier: "%.0f")°")
                .font(.headline)
            
            Image(systemName: "location.north.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: locationManager.currentHeading))
        }
        .padding()
        .onAppear {
            locationManager.startHeadingUpdates()
        }
        .onDisappear {
            locationManager.stopHeadingUpdates()
        }
    }
}

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}
