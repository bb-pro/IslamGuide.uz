//
//  CompassView.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//
import SwiftUI
import CoreLocation
import Adhan
import Foundation

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }

    func toDegrees() -> Double {
        return self * 180.0 / .pi
    }
}

class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var qiblaDirection: CLLocationDirection = 0.0

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }

    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        updateQiblaDirection(manager.location?.coordinate)
    }

    func updateQiblaDirection(_ userCoordinates: CLLocationCoordinate2D?) {
        guard let userCoordinates = userCoordinates else { return }

        let qiblaCoordinates = CLLocationCoordinate2D(latitude: 21.4225, longitude: 39.8262) // Coordinates for the Kaaba in Mecca

        let qiblaAngle = bearingBetweenLocations(userCoordinates, qiblaCoordinates)
        qiblaDirection = qiblaAngle
    }

    private func bearingBetweenLocations(_ source: CLLocationCoordinate2D, _ destination: CLLocationCoordinate2D) -> CLLocationDirection {
        let lat1 = source.latitude.toRadians()
        let lon1 = source.longitude.toRadians()

        let lat2 = destination.latitude.toRadians()
        let lon2 = destination.longitude.toRadians()

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)

        let degreesBearing = radiansBearing.toDegrees()
        let positiveDegreesBearing = (degreesBearing.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)

        return positiveDegreesBearing
    }
}

struct CompassView: View {
    @ObservedObject private var locationDelegate = LocationDelegate()

    var body: some View {
        VStack {
            Text("Qibla Direction: \(locationDelegate.qiblaDirection, specifier: "%.2f")°")
                .font(.headline)
                .padding()

            Spacer()

            Image(systemName: "location.north.fill")
                .font(.system(size: 120))
                .rotationEffect(Angle(degrees: locationDelegate.qiblaDirection), anchor: .center)

            Spacer()
        }
        .onAppear {
            locationDelegate.startUpdatingHeading()
        }
        .onDisappear {
            locationDelegate.stopUpdatingHeading()
        }
    }
}
struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}
