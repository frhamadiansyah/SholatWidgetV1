//
//  ObservableObject.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 24/10/20.
//

import Foundation
import Combine
import CoreLocation

class SholatObservableObject : ObservableObject {
    
    @Published var sholatTime: SholatTime?
//    private var sholatTiming : SholatTimings
    @Published var placemark: CLPlacemark?
    static var shared = SholatObservableObject(loc: LocationManager())
    
    let service = SholatAPIService.shared
    let loc: LocationManager
    
    private var subscriber: AnyCancellable?
    
    init(loc: LocationManager) {
//        getSholatTime()
        self.loc = loc
        loc.start()
        
        subscriber = loc.$thisLocation
                    .debounce(for: 1, scheduler: DispatchQueue.main) // wait for 5 sec to avoid often reload
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] location in
                        guard location != nil else { return }
                        self?.runCode()
                        self?.getLocationName()
//                        self?.fetchWaktuSholat(completion: { (result) in
//                            switch result {
//                            case .success(let sholat):
//                                DispatchQueue.main.async {
//                                    self?.sholatTime = sholat
//                                }
//                            case .failure(let error):
//                                DispatchQueue.main.async {
//                                    print(error.localizedDescription)
//                                }
//                            }
//                        })
                    }
    }
    @objc func runCode() {

        fetchWaktuSholat { [weak self] (result) in
            switch result {
            case .success(let sholat):
                DispatchQueue.main.async {
                    self?.sholatTime = sholat
                }
            case .failure(_):
                DispatchQueue.main.async {
                    print("error in sholat view model")
                }
            }
        }

    }
    
    func getLocationName() {
        self.loc.getPlace(for: loc.thisLocation!, completion: { [weak self] (locationName) in
            self?.placemark = locationName
        })
    }
    
    private func fetchWaktuSholat(completion : @escaping (Result<SholatTime, Error>) -> Void) {
        if needRefresh() {
            guard let lat = loc.thisLocation?.coordinate.latitude else { return  }
            guard let lon = loc.thisLocation?.coordinate.longitude else { return  }
//            let lat = loc.thisLocation?.coordinate.latitude ?? 40.2 //pondok aren latitude
//            let lon = loc.thisLocation?.coordinate.longitude ?? 72.11 // pondok aren longitude

            service.getTodaySholatTimeFromCoordinates(latitude: lat, longitude: lon) { (result) in
                switch result {
                case .success(let stats):
                    let userDefault = UserDefaults.standard
                    do {
                        try userDefault.setObject(stats, forKey: Def.sholat)
                    } catch {
                        completion(.failure(error))
                    }
                    let entry = SholatTime(waktuSholat: stats)
                    completion(.success(entry))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let userDefault = UserDefaults.standard
            do {
                let stats = try userDefault.getObject(forKey: Def.sholat, castTo: SholatTimings.self)
                let entry = SholatTime(waktuSholat: stats)
                completion(.success(entry))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func needRefresh() -> Bool {
        var boolDate = true
        let format = DateFormatter()
        format.dateStyle = .short
        let dateString = format.string(from: Date())
        
        if let date = UserDefaults.standard.string(forKey: Def.date) {
            if dateString == date {
                boolDate = false
            } else {
                boolDate = true
            }
        }
        var boolLoc = true
        if let locality = UserDefaults.standard.string(forKey: Def.location) {
            if locality == loc.locationName?.locality {
                boolLoc = false
            } else {
                boolLoc = true
            }
        }
        
        var boolMethod = true
        if let method = UserDefaults.standard.string(forKey: Def.method) {
            if method == service.method.info.name {
                boolMethod = false
            } else {
                boolMethod = true
            }
        }
        return boolDate && boolLoc && boolMethod
        
    }
}
