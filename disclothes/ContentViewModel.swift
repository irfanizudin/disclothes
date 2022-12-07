//
//  ContentViewModel.swift
//  disclothes
//
//  Created by Irfan Izudin on 07/12/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    
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
