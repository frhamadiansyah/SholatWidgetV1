//
//  SettingView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 08/11/20.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settingVM = SettingViewModel.shared
    
    @State var alertVisible: Bool = false
    
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
                        Button(action: {
                            self.alertVisible.toggle()
                            }
                        , label: {
                            Text("Widget Location Services")
                        })
                        .alert(isPresented: $alertVisible) {
                            Alert (title: Text("Widget Location Services is required"),
                                   message: Text("To fully utilize widget services, open Settings>Privacy>Location Services>SholatWidget and select 'allow location access while Using the Apps and Widgets' "),
                                   primaryButton: .default(Text("Settings"), action: {
                                       UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                   }),
                                   secondaryButton: .default(Text("Cancel")))
                               }
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
