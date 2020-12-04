//
//  WidgetLocationManager.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 23/11/20.
//

import Foundation
import WidgetKit
import CoreLocation

class WidgetLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    @Published var thisLocation: CLLocation?
    
    @Published var locationName: CLPlacemark?
    static let shared = WidgetLocationManager()

//    private var handler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        self.manager.delegate = self
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestAlwaysAuthorization()

        }
 
    }

    func start() {
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()

        DispatchQueue.main.async {

            self.thisLocation = self.manager.location
            print("-->Widget get location \(self.thisLocation)")
            
            if let coordinate = self.thisLocation {
                self.getPlace(for: coordinate) { (placemark) in
                    self.locationName = placemark
                }
            }
            
        }
        
    }
    
//    func fetchLocation(handler: @escaping (CLLocation) -> Void) {
//            self.handler = handler
//            self.manager.requestWhenInUseAuthorization()
//            self.manager.requestLocation()
//        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        thisLocation = locations.first
        self.thisLocation = self.manager.location
        print("-->Widget get location Manager \(self.thisLocation)")

        
        
    }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {

                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {

                completion(nil)
                return
            }
            
            UserDefaults.standard.set(placemark.subAdministrativeArea, forKey: Def.location)
            
            completion(placemark)
        }
    }

}
