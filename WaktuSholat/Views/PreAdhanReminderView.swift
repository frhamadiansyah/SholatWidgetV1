//
//  PreAdhanReminderView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 28/11/20.
//

import SwiftUI

struct PreAdhanReminderView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var settingVM: SettingViewModel = SettingViewModel.shared
    
    var body: some View {
        List {
            Button(action: {
                self.settingVM.minuteBeforeAdhan = 30
                if self.settingVM.turnOnNotification {
                    self.settingVM.notif.addSholatNotification(time: self.settingVM.minuteBeforeAdhan)
                }
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("30 Minutes")
                    Spacer()
                    if self.settingVM.minuteBeforeAdhan == 30 {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(Def.secondary))
                    }
                }
            })
            
            Button(action: {
                self.settingVM.minuteBeforeAdhan = 20
                if self.settingVM.turnOnNotification {
                    self.settingVM.notif.addSholatNotification(time: self.settingVM.minuteBeforeAdhan)
                }
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("20 Minutes")
                    Spacer()
                    if self.settingVM.minuteBeforeAdhan == 20 {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(Def.secondary))
                    }
                }
            })
            
            Button(action: {
                self.settingVM.minuteBeforeAdhan = 10
                if self.settingVM.turnOnNotification {
                    self.settingVM.notif.addSholatNotification(time: self.settingVM.minuteBeforeAdhan)
                }
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("10 Minutes")
                    Spacer()
                    if self.settingVM.minuteBeforeAdhan == 10 {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(Def.secondary))
                    }
                }
            })
        }.navigationTitle("Pre-Adhan Notification")
    }
}

struct PreAdhanReminderView_Previews: PreviewProvider {
    static var previews: some View {
        PreAdhanReminderView()
    }
}
