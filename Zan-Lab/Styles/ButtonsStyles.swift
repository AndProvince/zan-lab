//
//  ButtonsStyles.swift
//  Zan-Lab
//
//  Created by Андрей on 04.10.2023.
//

import Foundation
import SwiftUI

struct TopSituationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(12.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct MainBlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(12.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
