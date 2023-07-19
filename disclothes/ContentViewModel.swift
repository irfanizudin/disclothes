//
//  ContentViewModel.swift
//  disclothes
//
//  Created by Irfan Izudin on 07/12/22.
//

import Foundation
import UIKit

class ContentViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var showCameraPicker: Bool = false
    @Published var showAlert: Bool = false

    var limit: Int = 2
    @Published var discount1: String = "" {
        didSet {
            if discount1.count > limit {
                discount1 = String(discount1.prefix(limit))
            }
        }
    }
    
    @Published var discount2: String = "" {
        didSet {
            if discount2.count > limit {
                discount2 = String(discount2.prefix(limit))
            }
        }
    }

}
