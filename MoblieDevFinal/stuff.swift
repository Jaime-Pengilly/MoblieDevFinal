//import Foundation
//
//import SwiftUI
//
//
//enum Pokemon:String, CaseIterable, Identifiable{
//    var id: Pokemon{self}
//    case pokeBall = "Pokeball"
//    case pikachu = "Pikachu"
//    case psyduck = "Psyduck"
//    case bulbasaur = "Bulbasaur"
//    case charmander = "Charmander"
//    case evee = "Evee"
//    case jigglypuff = "Jigglypuff"
//    case squritle = "Squritle"
//    
//    var type: String{
//        switch self{
//        case .pokeBall:
//                "N/A"
//        case .pikachu:
//                "Electric"
//        case .psyduck:
//                "Water"
//        case .bulbasaur:
//                "Grass, Poison"
//        case .charmander:
//                "Fire"
//        case .evee:
//                "Normal"
//        case .jigglypuff:
//                "Normal, Fairy"
//        case .squritle:
//                "Water"
//        }
//    }
//    
//    var image: ImageResource{
//        switch self {
//        case .pokeBall:
//                .pokeball
//        case .pikachu:
//                .pikachu
//        case .psyduck:
//                .psyduck
//        case .bulbasaur:
//                .bulbasaur
//        case .charmander:
//                .charmander
//        case .evee:
//                .evee
//        case .jigglypuff:
//                .jigglypuff
//        case .squritle:
//                .squritle
//        }
//        
//    }
//}
