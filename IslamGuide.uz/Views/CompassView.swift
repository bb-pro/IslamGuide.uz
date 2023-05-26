//
//  CompassView.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//
import SwiftUI
import CoreLocation
import Adhan

struct CompassView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var qiblaDirection: Double?
    @State private var isCalculating: Bool = false
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            Image("qiblaDirection")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .rotationEffect(getQiblaRotationAngle())
                .animation(.default)
                .clipShape(Circle())
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Button(action: {
                    toggleCalculation()
                }) {
                    Text(buttonTitle)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color("tintColor"))
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
        }
        .aspectRatio(contentMode: .fill)
    }
    
    private var buttonTitle: String {
        isCalculating ? "Stop".localize() : "Find Qibla".localize()
    }
    
    private func toggleCalculation() {
        isCalculating.toggle()
        
        if isCalculating {
            calculateQiblaDirection()
        }
    }
    
    private func calculateQiblaDirection() {
        guard let currentLocation = locationManager.currentLocation?.coordinate else {
            return
        }
        
        let coordinates = Coordinates(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let qiblaDirection = Qibla(coordinates: coordinates).direction
        
        let qiblaDirectionDegrees = qiblaDirection * 180.0 / .pi
        self.qiblaDirection = qiblaDirectionDegrees
    }
    
    private func getQiblaRotationAngle() -> Angle {
        guard isCalculating,
              let heading = locationManager.currentHeading?.trueHeading,
              let qiblaDirection = qiblaDirection else {
            return .zero
        }
        
        let rotationAngle = qiblaDirection - heading
        return .degrees(rotationAngle)
    }
}



//import SwiftUI
//import CoreLocation
//import Adhan
//
//struct CompassView: View {
//    @StateObject private var locationManager = LocationManager()
//    @State private var qiblaDirection: Double?
//
//    var body: some View {
//        ZStack {
//            Color("background")
//                .ignoresSafeArea()
//            Image("qiblaDirection")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 250, height: 250)
//                .rotationEffect(getQiblaRotationAngle())
//                .animation(.default)
//                .onAppear {
//                    calculateQiblaDirection()
//                }
//                .clipShape(Circle())
//                .ignoresSafeArea()
//        }
//        .aspectRatio(contentMode: .fill)
//    }
//
//
//
//
//
//    func getQiblaRotationAngle() -> Angle {
//        guard let heading = locationManager.currentHeading?.trueHeading,
//              let qiblaDirection = qiblaDirection else {
//            return .zero
//        }
//
//        let rotationAngle = qiblaDirection - heading
//        return .degrees(rotationAngle)
//    }
//
//    func getQiblaDirection() -> String {
//        guard let qiblaDirection = qiblaDirection else {
//            return "Unknown"
//        }
//
//        let directionDifference = abs(qiblaDirection)
//        let formattedDifference = String(format: "%.1f", directionDifference)
//
//        if directionDifference < 5 {
//            return "Facing Qibla"
//        } else {
//            return "Turn \(formattedDifference)°"
//        }
//    }
//
//    func calculateQiblaDirection() {
//        guard let currentLocation = locationManager.currentLocation?.coordinate else {
//            return
//        }
//
//        let coordinates = Coordinates(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
//        let qiblaDirection = Qibla(coordinates: coordinates).direction
//
//        let qiblaDirectionDegrees = qiblaDirection * 180.0 / .pi
//        self.qiblaDirection = qiblaDirectionDegrees
//    }
//}
//
//struct QiblaView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompassView()
//    }
//}
