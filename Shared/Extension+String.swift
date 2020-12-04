//
//  Extension+String.swift
//  WaktuSholatWidgetExtension
//
//  Created by Fandrian Rhamadiansyah on 25/10/20.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func capitalizingEachWords() -> String {
        return capitalized
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeDashSymbols() -> String {
        return self.replace(string: "-", replacement: " ")
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func regex(pattern: String) -> [String] {
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: "#", with: "").lowercased()
            }
        }
        
        return []
    }
}
