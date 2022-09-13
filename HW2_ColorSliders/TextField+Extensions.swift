//
//  TextField + bordered.swift
//  HW2_ColorSliders
//
//  Created by Alexander Zubach on 12.09.2022.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            )
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 1, y: 2)
    }
}

extension TextField {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BorderedViewModifier())
    }
}
