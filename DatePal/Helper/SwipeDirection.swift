//
//  SwipeDirection.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import SwiftUI

/// Swipe Direction
enum SwipeDirection {
    case leading
    case trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}
