//
//  WaktuSholatTimelineProvider.swift
//  WaktuSholatWidgetExtension
//
//  Created by Fandrian Rhamadiansyah on 25/10/20.
//

import Foundation
import WidgetKit
import CoreLocation
import Combine

struct WaktuSholatTimelineProvider : TimelineProvider {
    
    typealias Entry = WaktuSholatEntry
    
    let service = SholatAPIService.shared
    
    var loc = WidgetLocationManager.shared
    //    let loc = LocationManager.shared
    
    private var subscriber: AnyCancellable?
    
    func placeholder(in context: Context) -> WaktuSholatEntry {
        WaktuSholatEntry.placeholder
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WaktuSholatEntry) -> Void) {
        if context.isPreview {

            completion(WaktuSholatEntry.placeholder)
        } else {
            fetchWaktuSholat { (result) in
                switch result {
                case .success(let entry) :
                    completion(entry)
                case .failure(_) :
                    completion(WaktuSholatEntry.placeholder)
                }
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WaktuSholatEntry>) -> Void) {

        fetchWaktuSholat { (result) in
            switch result {
            case .success(let entry) :
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*5)))

                completion(timeline)
            case .failure(_) :
                let timeline = Timeline(entries: [WaktuSholatEntry.placeholder], policy: .after(Date().addingTimeInterval(60*1)))

                completion(timeline)
            }
        }
        //        }

    }
    
    
}


//MARK: - Timeline Provider Custom Function

extension WaktuSholatTimelineProvider {
    
    private func fetchWaktuSholat(completion : @escaping (Result<WaktuSholatEntry, SholatAPIError>) -> ()) {
        
        


        loc.start()
//        let lat = Double(UserDefaults.standard.float(forKey: Def.lat))
//        let lon = Double(UserDefaults.standard.float(forKey: Def.lon))
        let lat = loc.thisLocation?.coordinate.latitude ?? 6//-6.249//pondok aren latitude
        let lon = loc.thisLocation?.coordinate.longitude ?? 39.2//106.85 // pondok aren longitude
        
//        if loc.thisLocation == nil {
//            completion(.failure(.noData))
//        }
        
//        let lat = -6.249
//        let lon = 106.85
//        if loc.thisLocation != nil {
//
//        }
        
        
        if !needRefresh() {
            let userDefault = UserDefaults.standard
            do {
                let stats = try userDefault.getObject(forKey: Def.sholat, castTo: SholatTimings.self)
                let entry = WaktuSholatEntry(date: Date(), sholatTime: .init(waktuSholat: stats))
                completion(.success(entry))
            } catch  {

                //                completion(.failure(error))
                service.getTodaySholatTimeFromCoordinates(latitude: lat, longitude: lon) { (result) in
                    
                    switch result {
                    case .success(let stats) :
                        let userDefault = UserDefaults.standard
                        do {
                            try userDefault.setObject(stats, forKey: Def.sholat)
                        } catch  {

                        }
                        let entry = WaktuSholatEntry(date: Date(), sholatTime: .init(waktuSholat: stats))
                        completion(.success(entry))
                    case .failure(let _) :
                        completion(.failure(.invalidSerialization))
                    }
                    
                }
            }
            
        } else {
            service.getTodaySholatTimeFromCoordinates(latitude: lat, longitude: lon) { (result) in
                
                switch result {
                case .success(let stats) :
                    let userDefault = UserDefaults.standard
                    do {
                        try userDefault.setObject(stats, forKey: Def.sholat)
                    } catch  {

                    }
                    let entry = WaktuSholatEntry(date: Date(), sholatTime: .init(waktuSholat: stats))
                    completion(.success(entry))
                case .failure(let error) :
                    completion(.failure(.invalidSerialization))
                }
                
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
