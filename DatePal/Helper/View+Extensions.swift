//
//  View+Extensions.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: alignment)
    }
    func captionText() -> some View {
        self
            .font(.caption)
            .foregroundStyle(.gray)
            .hSpacing(.leading)
    }
    
    func cardViewInput() -> some View {
        self
            .datePickerStyle(.graphical)
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(.background, in: .rect(cornerRadius: 10))
    }
    
    @available(iOSApplicationExtension, unavailable)
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

