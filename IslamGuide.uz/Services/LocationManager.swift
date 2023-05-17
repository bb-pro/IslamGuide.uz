//
//  LocationManager.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//

import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentHeading: Double = 0.0
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func startHeadingUpdates() {
        guard CLLocationManager.headingAvailable() else {
            print("Compass is not available on this device.")
            return
        }
        
        locationManager.headingFilter = 1
        locationManager.startUpdatingHeading()
    }
    
    func stopHeadingUpdates() {
        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        currentHeading = newHeading.trueHeading
    }
}
