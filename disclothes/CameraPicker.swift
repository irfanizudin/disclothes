//
//  CameraPicker.swift
//  disclothes
//
//  Created by Irfan Izudin on 06/12/22.
//

import Foundation
import SwiftUI


struct CameraPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = CameraPickerCoordinator
    
    @Binding var image: UIImage?
    @Binding var showCameraPicker: Bool
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraPicker.Coordinator {
        return CameraPickerCoordinator(image: $image, showCameraPicker: $showCameraPicker)
    }
    
}

class CameraPickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var showCameraPicker: Bool
    
    init(image: Binding<UIImage?>, showCameraPicker: Binding<Bool>) {
        _image = image
        _showCameraPicker = showCameraPicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            showCameraPicker = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        showCameraPicker = false
    }
}
