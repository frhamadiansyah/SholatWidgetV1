//
//  SettingViewModel.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 20/11/20.
//

import Foundation
import UserNotifications

class SettingViewModel: ObservableObject {
    
    static let shared = SettingViewModel()
    
    let sholatVM = SholatObservableObject.shared
    let notif = SholatNotification.shared
    
    
    @Published var minuteBeforeAdhan = UserDefaults.standard.integer(forKey: Def.preAdhan) ?? 20 {
        didSet {
            UserDefaults.standard.set(minuteBeforeAdhan, forKey: Def.preAdhan)
        }
    }
    
    
    @Published var turnOnNotification =  UserDefaults.standard.bool(forKey: Def.useNotif) ?? false {
        didSet {

            if turnOnNotification {
                notif.center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if success {

                        self.notif.addSholatNotification(time: self.minuteBeforeAdhan)
                    } else if let error = error {

                        print("NOTIF ERROR")
                    }
                }
                
                
            } else {
                notif.removeNotification()
                
            }
        }
    }
    
    
    
    @Published var useLocationService: Bool = true {
        didSet {
            if useLocationService {
                sholatVM.loc.manager.startMonitoringSignificantLocationChanges()
            } else {
                sholatVM.loc.manager.stopMonitoringSignificantLocationChanges()
            }
        }
    }
    
    @Published var calculationMethod: CalculationMethod = .muslimWorldLeague {
        didSet {
            self.sholatVM.service.method = calculationMethod
            UserDefaults.standard.set(calculationMethod.info.name, forKey: Def.method)
        }
    }
    
    
}
