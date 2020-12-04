//
//  CalculationMethod.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 29/11/20.
//

import Foundation

enum CalculationMethod: CaseIterable {
    case shiaIthnaAnsari
    case universityOfIslamicSciencesKarachi
    case islamicSocietyOfNorthAmerica
    case muslimWorldLeague
    case ummAlQuraUniversityMakkah
    case egyptianGeneralAuthorityOfSurvey
    case instituteOfGeophysicsUniversityOfTehran
    case gulfRegion
    case kuwait
    case qatar
    case majlisUgamaIslamSingapuraSingapore
    case unionOrganizationIslamicDeFrance
    case diyanetİşleriBaşkanlığıTurkey
    case spiritualAdministrationOfMuslimsOfRussia
    
    var info: (num: Int, name: String) {
        switch self {
        case .shiaIthnaAnsari:
            return (0, "Shia Ithna-Ansari")
        case .universityOfIslamicSciencesKarachi:
            return (1, "University of Islamic Sciences, Karachi")
        case .islamicSocietyOfNorthAmerica:
            return (2, "Islamic Society of North America")
        case .muslimWorldLeague:
            return (3, "Muslim World League")
        case .ummAlQuraUniversityMakkah:
            return (4, "Umm Al-Qura University, Makkah")
        case .egyptianGeneralAuthorityOfSurvey:
            return (5, "Egyptian General Authority of Survey")
        case .instituteOfGeophysicsUniversityOfTehran:
            return (7, "Institute of Geophysics, University of Tehran")
        case .gulfRegion:
            return (8, "Gulf Region")
        case .kuwait:
            return (9, "Kuwait")
        case .qatar:
            return (10, "Qatar")
        case .majlisUgamaIslamSingapuraSingapore:
            return (11, "Majlis Ugama Islam Singapura, Singapore")
        case .unionOrganizationIslamicDeFrance:
            return (12, "Union Organization islamic de France")
        case .diyanetİşleriBaşkanlığıTurkey:
            return (13, "Diyanet İşleri Başkanlığı, Turkey")
        case .spiritualAdministrationOfMuslimsOfRussia:
            return (14, "Spiritual Administration of Muslims of Russia")
        default:
            return (3, "Muslim World League")
        }
    }
}
