//
//  HomeView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 08/11/20.
//

import SwiftUI

struct HomeView: View { 
    var body: some View {
            TabView {
                ScheduleView()
                    .tabItem {
                        VStack {
                            Image(systemName: "clock.fill")
                            Text("Sholat Time")
                        }
                    }.tag(1)
                SettingView()
                    .tabItem {
                        VStack {
                            Image(systemName: "gear")
                            Text("Setting")
                        }
                    }.tag(2)
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
