//
//  SettingView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 08/11/20.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settingVM = SettingViewModel.shared
    
    var body: some View {
        HStack {
            NavigationView {
                List {
                    
                    Section(header: Text("Prayer Calculation")) {
                        // auto detect location
                        Toggle(isOn: $settingVM.useLocationService) {
                            Text("Auto-detect Location")
                        }
                        if !settingVM.useLocationService {
                            NavigationLink (
                                destination: Text("Choose Location"),
                                label: {
                                    VStack(alignment: .leading) {
                                        Text("Location")
                                            .multilineTextAlignment(.leading)
                                        Text("\(settingVM.sholatVM.loc.locationName?.locality ?? "Coming Soon")")
    //                                    Text("SSS")
                                            .multilineTextAlignment(.leading)
                                            .font(.caption)
                                    }
                                })
                        }
                        NavigationLink(
                            destination: CalculationMethodView(),
                            label: {
                                Text("Calculation Method")
                            })

                        
                    }
                    
                    
                    Section(header: Text("Notification")) {
                        Toggle(isOn: $settingVM.turnOnNotification) {
                            Text("Notification")
                        }
                        
                        
                        NavigationLink(
                            destination: PreAdhanReminderView(),
                            label: {
                                HStack {
                                    Text("Pre-Adhan Reminder")
                                    Spacer()
                                    Text("\(settingVM.minuteBeforeAdhan) Minutes")
                                }
                            })
                        


                    }
                    
                    
                    
                    
                    
                    Section(header: Text("Other")) {
                        NavigationLink(
                            destination: AboutUsView(),
                            label: {
                                Text("About Us")
                            })
                        
                    }
                }
                .listStyle(GroupedListStyle())

                .navigationBarTitle("Settings", displayMode: .automatic)
                
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
