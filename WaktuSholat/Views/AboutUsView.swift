//
//  AboutUsView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 29/11/20.
//

import SwiftUI

struct AboutUsView: View {
    let about: String = "Hi! Sholat Widget is an app to reminds you about your praying time. This app is powered by : "
    

    
    var body: some View {
    
        VStack(alignment: .center, spacing: 20) {
            HStack(spacing: 20) {
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                Text("Version: ")
                Text("1.0")
            }

            
            Text("\(about)")
                .lineLimit(5)
            Link(destination: URL(string: "https://aladhan.com")!, label: {
                Text("aladhan.com")
            })
            
            Spacer()
        }
        .padding()
        .navigationTitle("About Us")
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
