//
//  Model.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 23/10/20.
//

import Foundation

struct Sholat: Decodable {
    let sholatCalendar: [SholatCalendar]
    let status: String

    enum CodingKeys: String, CodingKey {
        case sholatCalendar = "data"
        case status = "status"
    }
}

struct SholatCalendar: Decodable {
    let sholatDate: SholatDate
    let sholatSchedule: SholatTimings

    enum CodingKeys: String, CodingKey {
        case sholatDate = "date"
        case sholatSchedule = "timings"
    }
}

struct SholatDate: Decodable {
    let timestamp: String
    var sholatdate: Date? {
        let test = Double(timestamp)!
        return Date(timeIntervalSince1970: test)
    }
}

struct SholatTimings: Codable {
//    var id = UUID()
    let fajr: String
    let sunrise: String
    let dhuhr: String
    let asr: String
    let maghrib: String
    let isha: String

    enum CodingKeys: String, CodingKey {
        case fajr = "Fajr"
        case sunrise = "Sunrise"
        case dhuhr = "Dhuhr"
        case asr = "Asr"
        case maghrib = "Maghrib"
        case isha = "Isha"
    }
}

enum SholatName: String, CaseIterable {
    case fajr = "Fajr"
    case sunrise = "Dhuha"
    case dhuhr = "Dhuhr"
    case asr = "Asr"
    case maghrib = "Maghrib"
    case isha = "Isha"
}

struct SholatTime {
    
    var date: Date {
        // safe to user default
        let format = DateFormatter()
        format.dateStyle = .short
        let dateString = format.string(from: Date())
        UserDefaults.standard.set(dateString, forKey: Def.date)
        return Date()
    }

    let waktuSholat: SholatTimings
    
    var whatSholat: (currentSholat: SholatName, nextSholat : SholatName, nextSholatTime : Date, remainingTime: Int, duration: Int) {
        getWhatSholatTime(date: Date())
    }
    
    var sholatTimeDict: [SholatName: Date] {
        var temp: [SholatName: Date] = [:]
        temp[.fajr] = changeStringToTime(timeString: waktuSholat.fajr)
        temp[.sunrise] = changeStringToTime(timeString: waktuSholat.sunrise)
        temp[.dhuhr] = changeStringToTime(timeString: waktuSholat.dhuhr)
        temp[.asr] = changeStringToTime(timeString: waktuSholat.asr)
        temp[.maghrib] = changeStringToTime(timeString: waktuSholat.maghrib)
        temp[.isha] = changeStringToTime(timeString: waktuSholat.isha)
        return temp
    }
    
    private func changeStringToTime(timeString: String) -> Date {
        let sholatTime = timeString.regex(pattern: "^.....")[0]
        let hour = Int(sholatTime.regex(pattern: "^..")[0]) ?? 0
        let minute = Int(sholatTime.regex(pattern: "..$")[0]) ?? 0
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: date)!
    }
    public func getWhatSholatTime(date: Date) -> (currentSholat: SholatName, nextSholat : SholatName, nextSholatTime : Date, remainingTime: Int, duration: Int) {
        let calendar = Calendar.current
        if date < changeStringToTime(timeString: waktuSholat.fajr) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.fajr)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: Date(timeInterval: -60*60*24, since: changeStringToTime(timeString: waktuSholat.isha)), to: changeStringToTime(timeString: waktuSholat.fajr)).minute!
            return (SholatName.isha, SholatName.fajr, changeStringToTime(timeString: waktuSholat.fajr), currentDifference, sholatDuration)
        } else if date < changeStringToTime(timeString: waktuSholat.sunrise) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.sunrise)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.fajr), to: changeStringToTime(timeString: waktuSholat.sunrise)).minute!
            return (SholatName.fajr, SholatName.sunrise, changeStringToTime(timeString: waktuSholat.sunrise), currentDifference, sholatDuration)
        } else if date < changeStringToTime(timeString: waktuSholat.dhuhr) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.dhuhr)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.sunrise), to: changeStringToTime(timeString: waktuSholat.dhuhr)).minute!
            return (SholatName.sunrise, SholatName.dhuhr, changeStringToTime(timeString: waktuSholat.dhuhr), currentDifference, sholatDuration)
        } else if date < changeStringToTime(timeString: waktuSholat.asr) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.asr)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.dhuhr), to: changeStringToTime(timeString: waktuSholat.asr)).minute!
            return (SholatName.dhuhr, SholatName.asr, changeStringToTime(timeString: waktuSholat.asr), currentDifference, sholatDuration)
        } else if date < changeStringToTime(timeString: waktuSholat.maghrib) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.maghrib)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.asr), to: changeStringToTime(timeString: waktuSholat.maghrib)).minute!
            return (SholatName.asr, SholatName.maghrib, changeStringToTime(timeString: waktuSholat.maghrib), currentDifference, sholatDuration)
        } else if date < changeStringToTime(timeString: waktuSholat.isha) {
            let currentDifference = calendar.dateComponents([.minute], from: date, to: changeStringToTime(timeString: waktuSholat.isha)).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.maghrib), to: changeStringToTime(timeString: waktuSholat.isha)).minute!
            return (SholatName.maghrib, SholatName.isha, changeStringToTime(timeString: waktuSholat.isha), currentDifference, sholatDuration)
        } else {

            let currentDifference = calendar.dateComponents([.minute], from: date, to: Date(timeInterval: 60*60*24, since: changeStringToTime(timeString: waktuSholat.fajr))).minute!
            let sholatDuration = calendar.dateComponents([.minute], from: changeStringToTime(timeString: waktuSholat.isha), to: Date(timeInterval: 60*60*24, since: changeStringToTime(timeString: waktuSholat.fajr))).minute!
            let nextFajr = Date(timeInterval: 60*60*24, since: changeStringToTime(timeString: waktuSholat.fajr))
            
            return (SholatName.isha, SholatName.fajr, nextFajr, currentDifference, sholatDuration)
        }
    }
}
