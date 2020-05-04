//
//  ViewController.swift
//  Flower Picker
//
//  Created by Drew Dodson on 5/3/20.
//  Copyright © 2020 Arcalla.com. All rights reserved.
//

// YOU NEED THE MODEL FROM HERE: https://drive.google.com/uc?export=download&id=13v58uJqi_pAXKoBa2J7mZ7sLkaSRVUBb

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    let wikipediaAPIURL = "https://en.wikipedia.org/w/api.php"

    @IBOutlet var descriptionLabel: UILabel!
    
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            //imageView.image = image
            guard let ciimage = CIImage(image: image) else {
                fatalError("Error converting image")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }



    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Error loading CoreML model")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Error processing results")
            }
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier.capitalized
                self.requestInfo(flowerName: firstResult.identifier)
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



    func requestInfo(flowerName: String) {
        
        let parameters : [String:String] = [
        "format" : "json",
        "action" : "query",
        "prop" : "extracts|pageimages",
        "exintro" : "",
        "explaintext" : "",
        "titles" : flowerName,
        "indexpageids" : "",
        "redirects" : "1",
        "pithumbsize" : "500",
        ]
        
        Alamofire.request(wikipediaAPIURL, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let flowerJSON : JSON = JSON(response.result.value!)
                let pageID = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageID]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageID]["thumbnail"]["source"].stringValue
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                self.descriptionLabel.text = flowerDescription
            }
        }
    }





}
