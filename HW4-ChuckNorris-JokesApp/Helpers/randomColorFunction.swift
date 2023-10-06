//
//  randomColorFunction.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/5/23.
//

import Foundation
import SwiftUI

func randomColor() -> Color {
    return Color(
        red: Double.random(in: 0.8...1),
        green: Double.random(in: 0.8...1),
        blue: Double.random(in: 0.8...1)
    )
}
