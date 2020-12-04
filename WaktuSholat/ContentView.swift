//
//  ContentView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 22/10/20.
//

import SwiftUI

//struct ContentView: View {
//    
//    @ObservedObject var entry = SholatObservableObject()
//    
//    let locationFetcher = LocationManager()
//    
//    
//    var body: some View {
//        if let time = entry.sholatTime {
//            ExtractedView(time: time)
//        } else {
//            Text("Loading")
//        }
//        
//        
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct ExtractedView: View {
//    
//    let time: SholatTime
//    let locationFetcher = LocationFetcher()
//    
//    var body: some View {
//        ZStack {
//            ProgressBar(duration: time.whatSholat.duration, remainingTime: time.whatSholat.remainingTime)
//                .padding()
//            
//            VStack(alignment: .center) {
//                
//                // test location center
//                Button("Start Tracking Location") {
//                    self.locationFetcher.start()
//                }
//                
//                Button("Read Location") {
//                    if let location = self.locationFetcher.lastKnownLocation {
//                        print("Your location is \(location)")
//                        
//                        
//                    } else {
//                        print("Your location is unknown")
//                    }
//                }
//                
//                Text("Waktu Sholat \(time.whatSholat.currentSholat.rawValue)")
//                    .font(.subheadline)
//                    .padding()
//                Text(time.whatSholat.nextSholatTime, style: .relative)
//                    .font(.footnote)
//                    .multilineTextAlignment(.center)
//                //                        .frame(width: .infinity, alignment: .center)
//                
//                
//            }
//        }
//    }
//}
