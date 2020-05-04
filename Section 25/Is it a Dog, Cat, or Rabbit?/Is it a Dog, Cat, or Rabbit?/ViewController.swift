//
//  ViewController.swift
//  Is it a Dog, Cat, or Rabbit?
//
//  Created by Drew Dodson on 5/4/20.
//  Copyright © 2020 Arcalla.com. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            guard let convertedCIImage = CIImage(image: image) else {
                fatalError("Could not convert to CIImage")
            }
            detect(image: convertedCIImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: AnimalRecognitionModel().model) else {
            fatalError("Error loading CoreML model")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error processing results")
            }
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }
    
    
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
}
