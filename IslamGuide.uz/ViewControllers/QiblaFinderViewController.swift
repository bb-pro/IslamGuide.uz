//
//  QiblaFinderViewController.swift
//  IslamGuide.uz
//
//  Created by Bektemur Mamashayev on 17/05/23.
//

import UIKit
import CoreMotion
import Adhan
import CoreLocation

class QiblaFinderViewController: UIViewController {
    @IBOutlet weak var circleView: UIImageView!
    
    private let motionManager = CMMotionManager()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Start updating device orientation
        startUpdatingDeviceOrientation()
    }
    
    private func startUpdatingDeviceOrientation() {
        guard motionManager.isDeviceMotionAvailable else {
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) { [weak self] (motion, error) in
            guard let self = self, let motion = motion else {
                return
            }
            
            let rotation = atan2(motion.gravity.x, motion.gravity.y) - .pi
            self.circleView.transform = CGAffineTransform(rotationAngle: rotation)
        }
    }
    
    private func setQiblaDirection(userLocation: Coordinates) {
        let qiblaDirection = Qibla(coordinates: userLocation).direction
        rotateCircleView(angle: qiblaDirection)
    }
    
    private func rotateCircleView(angle: Double) {
        let rotationAngle = CGFloat(angle.radians)
        
        // Remove existing mark image view if it exists
        circleView.subviews.filter { $0 is UIImageView }.forEach { $0.removeFromSuperview() }
        
        // Add the mark image view to the circle view
        let markImageView = UIImageView(image: UIImage(systemName: "book")) // Replace "book" with the actual image name
        markImageView.contentMode = .top
        markImageView.frame = circleView.bounds
        markImageView.transform = CGAffineTransform(rotationAngle: -rotationAngle)
        
        // Calculate the position for the mark image view at the top of the circle
        let circleCenter = CGPoint(x: circleView.bounds.midX, y: circleView.bounds.midY)
        let radius = circleView.bounds.width / 2.0
        let markViewRadius = markImageView.bounds.width / 2.0
        let markCenterX = circleCenter.x + sin(rotationAngle) * (radius - markViewRadius)
        let markCenterY = circleCenter.y - cos(rotationAngle) * (radius - markViewRadius)
        markImageView.center = CGPoint(x: markCenterX, y: markCenterY)
        
        circleView.addSubview(markImageView)
    }



}

//MARK: - CLLocationManagerDelegate
extension QiblaFinderViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            let coordinates = Coordinates(
                latitude: userLocation.coordinate.latitude,
                longitude: userLocation.coordinate.longitude
            )
            setQiblaDirection(userLocation: coordinates)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location did fail with error: \(error.localizedDescription)")
    }
}

extension Double {
    var radians: Double {
        return self * .pi / 180.0
    }
    
    var degrees: Double {
        return self * 180.0 / .pi
    }
}

