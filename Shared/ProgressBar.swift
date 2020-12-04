//
//  ProgressBar.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 05/11/20.
//

import SwiftUI

struct ProgressBar: View {
    var duration : Int
    var remainingTime : Int
    
    var progress : CGFloat {
        return CGFloat(Double(remainingTime)/Double(duration))
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(self.progress < 0.25 ? Color(Def.tersiery) : Color(Def.secondary))
                .rotationEffect(Angle(degrees: 270.0))
//                .animation(.linear)
            
        }.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(duration: 200, remainingTime: 23)
    }
}
