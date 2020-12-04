//
//  LocationManager.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 21/11/20.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var thisLocation: CLLocation?
    @Published var locationName: CLPlacemark?
   
    
    static let shared = LocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        
    }

    func start() {
//        manager.requestWhenInUseAuthorization()
        manager.startMonitoringSignificantLocationChanges()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        thisLocation = locations.first
        
    }
}


extension LocationManager {
    
    
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
            UserDefaults.standard.set(placemark.location?.coordinate.latitude, forKey: Def.lat)
            UserDefaults.standard.set(placemark.location?.coordinate.longitude, forKey: Def.lon)
            
            completion(placemark)
        }
    }
}
