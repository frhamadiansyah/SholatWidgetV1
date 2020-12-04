//
//  SettingTableCell.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 20/11/20.
//

import SwiftUI

struct SettingTableCell: View {
    let title: String
    @State var isOn: Bool = true
    
    var body: some View {
        VStack {
            ProgressView(value: 0.5)
                .progressViewStyle(CircularProgressViewStyle())
            HStack {
                Text(title)
                
                Toggle(isOn: $isOn) {
                    Text("SDASDA")
                }
                
                
                
            }
        }
    }
}

struct SettingTableCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingTableCell(title: "Ubah")
    }
}


