//
//  CalculationMethodView.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 29/11/20.
//

import SwiftUI

struct CalculationMethodView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var settingVM = SettingViewModel.shared
    
    var body: some View {
        List(0..<CalculationMethod.allCases.count) { index in

            Button(action: {
                self.settingVM.sholatVM.service.method = CalculationMethod.allCases[index]
                self.settingVM.sholatVM.runCode()
                UserDefaults.standard.set(CalculationMethod.allCases[index].info.name, forKey: Def.method)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("\(CalculationMethod.allCases[index].info.name)")
                    Spacer()
                    if self.settingVM.sholatVM.service.method == CalculationMethod.allCases[index] {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(Def.secondary))
                    }
                }
            })
        }.navigationTitle("Calculation Method")
    }
}

struct CalculationMethodView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationMethodView()
    }
}
