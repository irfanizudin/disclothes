//
//  HideKeyboard.swift
//  disclothes
//
//  Created by Irfan Izudin on 06/12/22.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
