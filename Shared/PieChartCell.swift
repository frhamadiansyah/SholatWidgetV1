//
//  PieChartCell.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 05/11/20.
//

import SwiftUI

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x:self.midX, y: self.midY)
    }
}

struct PieChartCell: View {
    var rect : CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    
    var progress : CGFloat = CGFloat(0.8)
    
    var body: some View {
        ZStack {
            Path({ path in
                path.addArc(center:rect.mid , radius:self.radius, startAngle: Angle(degrees: self.startDeg), endAngle: Angle(degrees: self.endDeg), clockwise: true)
                path.addLine(to: rect.mid)
                path.closeSubpath()
            })
//            Circle().trim(from: 0.0, to: 0.4)
//                .frame(width: rect.width, height: rect.height, alignment: .center)
//                .foregroundColor(.red)
            
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
        }
        //        Text("Asda")
    }
}

struct PieChartCell_Previews: PreviewProvider {
    var rect = UIScreen.main.bounds
    
    static var previews: some View {
        PieChartCell(rect: .init(x: 10, y: 200, width: 100, height: 100), startDeg: 0, endDeg: 60)
    }
}
