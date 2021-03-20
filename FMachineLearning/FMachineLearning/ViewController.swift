//
//  ViewController.swift
//  FMachineLearning
//
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = view.frame
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            self.present(vc, animated: true)
        }
        view.addSubview(label)
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialMT", size: 25)
        label.text = "Detected Text Here"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        let image2 = VisionImage(image: image)
        textRecognizer.process(image2) { result, error in
          guard error == nil, let result = result else {
            // ...
            return
          }

            let resultText = result.text
            DispatchQueue.main.async {
                self.label.text = "\(resultText)"
            }
            print(resultText)
        }
            
    }
        

    
    
}

