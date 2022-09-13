//
//  ColoredRectangleView.swift
//  HW2_ColorSliders
//
//  Created by Alexander Zubach on 12.09.2022.
//

import SwiftUI

struct ColoredRectangleView: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.black)
            )
            .frame(height: 150)
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 1, y: 2)
    }
}
