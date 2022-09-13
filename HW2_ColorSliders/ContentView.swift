//
//  ContentView.swift
//  HW2_ColorSliders
//
//  Created by Alexander Zubach on 11.09.2022.
//

import SwiftUI

struct ContentView: View {
    
    enum FocusableTextFields: CaseIterable {
        case red
        case green
        case blue
    }
    
    @FocusState private var textFieldInFocus: FocusableTextFields?
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var redTextFieldText = ""
    @State private var greenTextFieldText = ""
    @State private var blueTextFieldText = ""
    
    @State private var shouldShowAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple, .yellow]),
                startPoint: .leading,
                endPoint: .trailing)
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                ColoredRectangleView(
                    color: Color(
                        red: redSliderValue / 255,
                        green: greenSliderValue / 255,
                        blue: blueSliderValue / 255))
                
                SliderTextFieldStackView(
                    textFieldText: $redTextFieldText,
                    sliderValue: $redSliderValue,
                    focused: $textFieldInFocus,
                    sliderColor: .red
                )
                
                SliderTextFieldStackView(
                    textFieldText: $greenTextFieldText,
                    sliderValue: $greenSliderValue,
                    focused: $textFieldInFocus,
                    sliderColor: .green
                )
                
                SliderTextFieldStackView(
                    textFieldText: $blueTextFieldText,
                    sliderValue: $blueSliderValue,
                    focused: $textFieldInFocus,
                    sliderColor: .blue
                )
                
                Spacer()
            }
            .padding()
        }
        .onSubmit {
            updateCurrentSlider()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: focusPreviousTextField) {
                    Image(systemName: "chevron.up")
                }
                .alert(
                    "Wrong format",
                    isPresented: $shouldShowAlert,
                    actions: {}
                ) {
                    Text("Only numbers within 0-255 range")
                }
                Button(action: focusNextTextField) {
                    Image(systemName: "chevron.down")
                }
                .alert(
                    "Wrong format",
                    isPresented: $shouldShowAlert,
                    actions: {}
                ) {
                    Text("Only numbers within 0-255 range")
                }
                Spacer()
                Button("Done") {
                    textFieldInFocus = nil
                }
            }
        }
    }
    
    private func focusPreviousTextField() {
        
        updateCurrentSlider()
        
        let textFields = FocusableTextFields.allCases
        
        guard let index = textFields.firstIndex(of: textFieldInFocus ?? .red) else {
            return
        }
        
        let previousIndex = index - 1
        
        if previousIndex >= 0 {
            textFieldInFocus = textFields[previousIndex]
        } else {
            textFieldInFocus = textFields.last
        }
    }
    
    private func focusNextTextField() {
        
        updateCurrentSlider()
        
        let textFields = FocusableTextFields.allCases
        
        guard let index = textFields.firstIndex(of: textFieldInFocus ?? .red) else {
            return
        }
        
        let nextIndex = index + 1
        
        if nextIndex < textFields.count {
            textFieldInFocus = textFields[nextIndex]
        } else {
            textFieldInFocus = textFields.first
        }
    }
    
    private func isInputValid(_ input: String) -> Bool {
        guard let newValue = Double(input),
              (0...255).contains(newValue)
        else {
            shouldShowAlert.toggle()
            return false
        }
        return true
    }
    
    private func updateCurrentSlider() {
        switch textFieldInFocus {
        
        case .red:
            redSliderValue = isInputValid(redTextFieldText) ? Double(redTextFieldText)! : 0
        case .green:
            greenSliderValue = isInputValid(greenTextFieldText) ? Double(greenTextFieldText)! : 0
        case .blue:
            blueSliderValue = isInputValid(blueTextFieldText) ? Double(blueTextFieldText)! : 0
        default:
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
