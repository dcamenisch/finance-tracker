//
//  Color+Extension.swift
//  FinanceTracker
//
//  Created by Danny on 28.06.2023.
//

import Foundation
import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}
