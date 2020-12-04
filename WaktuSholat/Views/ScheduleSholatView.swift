//
//  ScheduleSholatView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 22/11/20.
//

import SwiftUI

struct ScheduleSholatView: View {
    
    let time: SholatTime
    @ObservedObject var loc = LocationManager.shared
    
    init(time: SholatTime) {
        self.time = time
//        self.loc.start()
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "location.fill")
                })
                Spacer()
                
                if let place = self.loc.locationName {
                    Text("\(place.name!), \(place.locality!)")
                        .font(.title3)
//                        .multilineTextAlignment(.center)
                } else {
                    Text("Loading")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                
            }
            .padding()
            
            ZStack {
                ProgressBar(duration: time.whatSholat.duration, remainingTime: time.whatSholat.remainingTime)
                    .padding(30)
                
                VStack(alignment: .center) {
                    
                    // test location center
                    
                    Text("Waktu Sholat \(time.whatSholat.currentSholat.rawValue)")
                        .font(.subheadline)
                        .padding()
                    Text(time.whatSholat.nextSholatTime, style: .relative)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                    //                        .frame(width: .infinity, alignment: .center)
                    
                    
                }
            }
        }
    }
}

struct ScheduleSholatView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleSholatView(time: .init(waktuSholat: .init(fajr: "00:00 wib", sunrise: "00:00 wib", dhuhr: "00:00 wib", asr: "00:00 wib", maghrib: "00:00 wib", isha: "00:00 wib")))
    }
}
