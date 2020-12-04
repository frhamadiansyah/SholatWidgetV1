//
//  CalculationMethod.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 29/11/20.
//

import Foundation

enum CalculationMethod: CaseIterable {
    case ShiaIthnaAnsari
    case UniversityOfIslamicSciencesKarachi
    case IslamicSocietyOfNorthAmerica
    case MuslimWorldLeague
    case UmmAlQuraUniversityMakkah
    case EgyptianGeneralAuthorityOfSurvey
    case InstituteOfGeophysicsUniversityOfTehran
    case GulfRegion
    case Kuwait
    case Qatar
    case MajlisUgamaIslamSingapuraSingapore
    case UnionOrganizationIslamicDeFrance
    case DiyanetİşleriBaşkanlığıTurkey
    case SpiritualAdministrationOfMuslimsOfRussia
    
    var info: (num: Int, name: String) {
        switch self {
        case .ShiaIthnaAnsari:
            return (0, "Shia Ithna-Ansari")
        case .UniversityOfIslamicSciencesKarachi:
            return (1, "University of Islamic Sciences, Karachi")
        case .IslamicSocietyOfNorthAmerica:
            return (2, "Islamic Society of North America")
        case .MuslimWorldLeague:
            return (3, "Muslim World League")
        case .UmmAlQuraUniversityMakkah:
            return (4, "Umm Al-Qura University, Makkah")
        case .EgyptianGeneralAuthorityOfSurvey:
            return (5, "Egyptian General Authority of Survey")
        case .InstituteOfGeophysicsUniversityOfTehran:
            return (7, "Institute of Geophysics, University of Tehran")
        case .GulfRegion:
            return (8, "Gulf Region")
        case .Kuwait:
            return (9, "Kuwait")
        case .Qatar:
            return (10, "Qatar")
        case .MajlisUgamaIslamSingapuraSingapore:
            return (11, "Majlis Ugama Islam Singapura, Singapore")
        case .UnionOrganizationIslamicDeFrance:
            return (12, "Union Organization islamic de France")
        case .DiyanetİşleriBaşkanlığıTurkey:
            return (13, "Diyanet İşleri Başkanlığı, Turkey")
        case .SpiritualAdministrationOfMuslimsOfRussia:
            return (14, "Spiritual Administration of Muslims of Russia")
        default:
            return (3, "Muslim World League")
        }
    }
}
