//
//  ScheduleView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 08/11/20.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var sholatVM = SholatObservableObject(loc: LocationManager())


    var body: some View {
        NavigationView {
            VStack {
                if let time = sholatVM.sholatTime {
                    VStack {
                        HStack {
                            Button(action: {
                                self.sholatVM.getLocationName()
                            }, label: {
                                Image(systemName: "location.fill")
                            })
                            .multilineTextAlignment(.leading)
                            Spacer()
                            
                            if let place = self.sholatVM.placemark {
                                VStack {
                                    Text("\(place.locality!), \(place.administrativeArea!)")
    //                                Text("\((sholatVM.loc.thisLocation?.coordinate.latitude)!)")
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
//                                        .padding()
                                    
                                    
                                }
                            } else {
                                ProgressView(value: 0.5)
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        HStack {
                            Spacer()
                            Text(Date(), style: .date)
                                .padding()
                            Spacer()
                        }
                        
                        VStack {
      
                            ZStack {
                                ProgressBar(duration: time.whatSholat.duration, remainingTime: time.whatSholat.remainingTime)
                                    .padding(30)
                                
                                VStack(alignment: .center) {
                                    
                                    // test location center
                                    
                                    Text("Waktu Sholat")
                                        .font(.subheadline)
                                        .padding(.bottom, 5)
                                    Text("\(time.whatSholat.currentSholat.rawValue)")
                                        .font(.title)
                                        .bold()
                                        .padding(.bottom)
                                    Text(time.whatSholat.nextSholatTime, style: .relative)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                    //                        .frame(width: .infinity, alignment: .center)
                                    
                                    
                                }
                            }
                            
                        }
                    }

                    
                } else {
                    ProgressView(value: 0.5)
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }.navigationBarTitle("Sholat Time")
            
            
        }
        
        
    }
    
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
