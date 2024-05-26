//
//  TopicModel.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import SwiftUI

enum TopicCategory {
    case deepTalks
    case lightTalks
}

enum TopicModel: String, CaseIterable {
    // Light Talks
    case food = "Food"
    case pets = "Pets"
    case hobbies = "Hobbies"
    case travel = "Travel"
    case music = "Music"
    case movies = "Movies"
    case riddles = "Riddles"
    case kpop = "K-Pop"
    case school = "School"
    
    // Deep Talks
    case childhood = "Childhood"
    case engagement = "Engagement"
    case marriage = "Marriage"
    case courtship = "Courtship"
    case personality = "Personality"
    
    var emoji: String {
        switch self {
        // Light Talk Emojis
        case .food: return "🍔"
        case .pets: return "🐶"
        case .hobbies: return "🎨"
        case .travel: return "🚶‍♂️"
        case .music: return "🎵"
        case .movies: return "🎬"
        case .riddles: return "🤔"
        case .kpop: return "🎤"
        case .school: return "🏫"
        
        // Deep Talk Emojis
        case .childhood: return "👶"
        case .engagement: return "💍"
        case .marriage: return "💒"
        case .courtship: return "💑"
        case .personality: return "🧠"
        }
    }
    
    var topicName: String {
        return self.rawValue
    }
    
    var topicCategory: TopicCategory {
        switch self {
        case .food, .pets, .hobbies, .travel, .music, .movies, .riddles, .kpop, .school:
            return .lightTalks
        case .childhood, .engagement, .marriage, .courtship, .personality:
            return .deepTalks
        }
    }
}
