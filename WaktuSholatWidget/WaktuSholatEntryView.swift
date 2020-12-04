//
//  WaktuSholatEntryView.swift
//  WaktuSholatWidgetExtension
//
//  Created by Fandrian Rhamadiansyah on 25/10/20.
//

import SwiftUI
import WidgetKit

struct WaktuSholatEntryView: View {
    let entry : WaktuSholatEntry
    
    @Environment(\.widgetFamily) var family
    
    
    var body: some View {
        WaktuSholatWidgetSmall(entry: entry)
//        switch family {
//        case .systemSmall:
//            WaktuSholatWidgetSmall(entry: entry)
//        case .systemLarge :
//            WaktuSholatWidgetLarge(entry: entry)
//        default:
//            WaktuSholatWidgetMedium(entry: entry)
//        }
    }
}

struct WaktuSholatEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WaktuSholatEntryView(entry: WaktuSholatEntry.stub).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
