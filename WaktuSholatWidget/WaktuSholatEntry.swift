//
//  WaktuSholatEntry.swift
//  WaktuSholatWidgetExtension
//
//  Created by Fandrian Rhamadiansyah on 25/10/20.
//

import Foundation
import WidgetKit

struct WaktuSholatEntry : TimelineEntry {
    var date: Date
    
    let sholatTime : SholatTime
    
    var isPlaceholder = false

}

extension WaktuSholatEntry {
    
    static var stub : WaktuSholatEntry {
        WaktuSholatEntry(date: Date(), sholatTime: .init(waktuSholat: .init(fajr: "00:00 wib", sunrise: "00:00 wib", dhuhr: "00:00 wib", asr: "00:00 wib", maghrib: "00:00 wib", isha: "00:00 wib")))
    }
    
    static var placeholder : WaktuSholatEntry {
        WaktuSholatEntry(date: Date(), sholatTime: .init(waktuSholat:.init(fajr: "00:00 wib", sunrise: "00:00 wib", dhuhr: "00:00 wib", asr: "00:00 wib", maghrib: "00:00 wib", isha: "00:00 wib")),
                         isPlaceholder: true)
    }
}
