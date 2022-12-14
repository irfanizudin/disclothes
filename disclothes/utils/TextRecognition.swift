//
//  TextRecognition.swift
//  disclothes
//
//  Created by Irfan Izudin on 06/12/22.
//

import Foundation
import SwiftUI
import Vision


struct Variable {
    static var normalPrice: Double = 0
    static var finalPrice: Double = 0
    static var discount1: Double = 0
    static var discount2: Double = 0
}

func recognizeText(image: CGImage) {
    
    @StateObject var vm = ContentViewModel()

    let requestHandler = VNImageRequestHandler(cgImage: image)
    
    let request = VNRecognizeTextRequest { (request, error) in
        
        guard let observations = request.results as? [VNRecognizedTextObservation],
            error == nil else {
            return
        }
        
        filterText(observations: observations)
       
    }
        
    do {
        try requestHandler.perform([request])
    } catch {
        print("Unable to perform the request: \(error)")
    }
    
}

func filterText(observations: [VNRecognizedTextObservation]) {
    let text = observations.compactMap({ $0.topCandidates(1).first?.string })
    
    var newArray1 = [String]()
    for item in text{
        let splitSpace = item.split(separator: " ").joined(separator:"")
        newArray1.append(splitSpace)
    }
    var newArray2 = [String]()
    for item in newArray1{
        let splitDot = item.split(separator: ".").joined(separator:"")
        newArray2.append(splitDot)
    }
    var newArray3 = [String]()
    for item in newArray2{
        let splitComma = item.split(separator: ",").joined(separator:"")
        newArray3.append(splitComma)
    }
    var newArray4 = [String]()
    for item in newArray3{
        let splitR = item.split(separator: "R").joined(separator:"")
        newArray4.append(splitR)
    }
    var newArray5 = [String]()
    for item in newArray4{
        let splitP = item.split(separator: "p").joined(separator:"")
        newArray5.append(splitP)
    }
    
    var filterPrice: [Double] = [0]
    
    for text in newArray5 {
        let convertDouble = Double(text)
        if convertDouble != nil {
            filterPrice.append(Double(text)!)
        }
    }
    
    Variable.normalPrice = filterPrice[filterPrice.count - 1]
    print(Variable.normalPrice)
    
    calculateDiscount(normalPrice: Variable.normalPrice, discount1: Variable.discount1, discount2: Variable.discount2)
}


func calculateDiscount(normalPrice: Double, discount1: Double, discount2: Double) {
    
    let discount1 = discount1
    let discount2 = discount2
    
    let discountPrice1 = (discount1/100.0) * normalPrice
    let discountPrice2 = (discount2/100.00) * discountPrice1
    
    Variable.finalPrice = normalPrice - ( discountPrice1 + discountPrice2 )

}
