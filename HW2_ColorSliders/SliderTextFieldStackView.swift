//
//  SliderTextFieldStackView.swift
//  HW2_ColorSliders
//
//  Created by Alexander Zubach on 12.09.2022.
//

import SwiftUI

struct ColorSliderView: View {
    @Binding var value: Double
    
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(color)
                .frame(width: 50)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .animation(.linear(duration: 1), value: value)
        }
    }
}

struct SliderTextFieldStackView: View {
    
    typealias FocusableTextFields = ContentView.FocusableTextFields
    
    @Binding var textFieldText: String
    @Binding var sliderValue: Double
    
    var focused: FocusState<FocusableTextFields?>.Binding
    
    let sliderColor: Color
    
    var body: some View {
        HStack {
            ColorSliderView(value: $sliderValue, color: sliderColor)
            TextField("", text: $textFieldText)
                .bordered()
                .background(Color.white)
                .frame(width: 65, height: 30)
                .focused(focused, equals: setFocusedValue())
                .keyboardType(.decimalPad)
        }
        .onChange(of: sliderValue) { newValue in
            textFieldText = String(lround(newValue))
        }
        .onAppear {
            textFieldText = String(lround(sliderValue))
        }
    }
    
    private func setFocusedValue() -> FocusableTextFields {
        switch sliderColor {
            
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        default:
            return .red
        }
    }
}
