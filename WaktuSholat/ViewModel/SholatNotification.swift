//
//  NotificationCenter.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 27/11/20.
//

import Foundation
import UserNotifications

class SholatNotification {
    
    static let shared = SholatNotification()
    
    let center = UNUserNotificationCenter.current()
    
    
    var sholatTime: SholatTime? {
        getSholatTimeforNotif()
            
    }
    
    func getSholatTimeforNotif() -> SholatTime? {
        let userDefault = UserDefaults.standard
        do {
            let stats = try userDefault.getObject(forKey: Def.sholat, castTo: SholatTimings.self)
            let entry = SholatTime(waktuSholat: stats)
            return entry
        } catch  {

            return nil
        }
    }
    
    func goNotif() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
            success, error in
            if success {

            } else if let error = error {
                print("Notif error")
            }
            
            
        }
        // 2.
        let content = UNMutableNotificationContent()
        content.title = "Notification Tutorial"
        content.subtitle = "from ioscreator.com"
        content.body = " Notification triggered"
        content.sound = UNNotificationSound.default
        

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        // 5.
        UNUserNotificationCenter.current().add(request)

    }
    
    func beforeTimeContent(currentSholat: SholatName, time: Int, sholatTime: SholatTime) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Jangan Lupa Sholat \(currentSholat.rawValue)!"
        content.body = "Waktu Sholat \(currentSholat.rawValue) tinggal \(time) menit lagi"
        content.sound = UNNotificationSound.default
        
        
        var dateComp = DateComponents()
        dateComp.hour = Calendar.current.component(.hour, from: sholatTime.sholatTimeDict[currentSholat]!)
        dateComp.minute = Calendar.current.component(.minute, from: sholatTime.sholatTimeDict[currentSholat]!) - time
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        return UNNotificationRequest(identifier: "notification_endOf_\(currentSholat.rawValue)", content: content, trigger: trigger)
    }
    
    
    func newSholatContent(currentSholat: SholatName, sholatTime: SholatTime) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Waktu Sholat \(currentSholat.rawValue)!"
        content.body = "Waktu Sholat \(currentSholat.rawValue)"
        content.sound = UNNotificationSound.default
        
        
        var dateComp = DateComponents()
        dateComp.hour = Calendar.current.component(.hour, from: sholatTime.sholatTimeDict[currentSholat]!)
        dateComp.minute = Calendar.current.component(.minute, from: sholatTime.sholatTimeDict[currentSholat]!)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
        return UNNotificationRequest(identifier: "notification_\(currentSholat.rawValue)", content: content, trigger: trigger)
    }
    
    
    func addSholatNotification(time: Int) {
        self.center.removeAllDeliveredNotifications()
        self.center.removeAllPendingNotificationRequests()
        
        if let sholat = self.sholatTime {
            
            for i in SholatName.allCases {
                if i != .sunrise {
                    self.center.add(beforeTimeContent(currentSholat: i, time: time, sholatTime: sholat))
                    self.center.add(newSholatContent(currentSholat: i, sholatTime: sholat))
                }
            }
        }
        
        // test
//        let content = UNMutableNotificationContent()
//        content.title = "THIS IS A TEST"
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//        let req = UNNotificationRequest(identifier: "satu", content: content, trigger: trigger)
//        self.center.add(req) { (error) in
//            print("Test Notif added")
//        }
    }
    
    func removeNotification() {
        self.center.removeAllDeliveredNotifications()
        self.center.removeAllPendingNotificationRequests()
    }
    
    
}
