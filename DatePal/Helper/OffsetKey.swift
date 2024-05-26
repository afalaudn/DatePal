//
//  OffsetKey.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
