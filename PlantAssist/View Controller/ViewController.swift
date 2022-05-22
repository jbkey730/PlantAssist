//
//  ViewController.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 3/26/22.
//

import UIKit
import CoreML
import Vision
import Social

extension UIImage {
    func resize(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
        let widthRatio  = width / size.width
        let heightRatio = height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var homeScreeImageview: UIImageView!
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
       let imagePicker = UIImagePickerController()
       var classificationResults : [VNClassificationObservation] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           imagePicker.delegate = self
           
       }

           
   func detect(image: CIImage) {
       //var imageCropAndScaleOption: VNImageCropAndScaleOption = .scaleFill
       
           //Load the ML model through its generated class
       guard let model = try? VNCoreMLModel(for: club(configuration: MLModelConfiguration()).model) else {
           fatalError("can't load ML model")
           }
          
       let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
                                                   
           let topResult = results.first
               
               //VNImageCropAndScaleOption
                                                                                             
           else{
               fatalError("unexpected result type from VNCoreMLRequest")
           }
           let confidenceRate = (topResult.confidence) * 100

           //print(topResult)
           var topResultDec: String
           topResultDec = NSString(format: "%.2f",confidenceRate) as String
           
           let threshed: Double = 50
           let thresh: String = String(format: "%.2f", threshed)
           let laxText: String = "Lax Wheat"
           let clubText: String = "Club Wheat"

           if topResultDec > thresh {
               DispatchQueue.main.async {
                   //self.navigationItem.title = "Lax Wheat
                   self.textView.text = laxText
                   
                   //self.navigationItem.title = String(topResultDec)
                   //self.navigationController?.navigationBar.barTintColor = UIColor.orange
                   //self.navigationController?.navigationBar.isTranslucent = false
                                           }
           }
               else{
                   DispatchQueue.main.async {
                       //self.navigationItem.title = String(topResultDec) //"Club
                       //self.navigationItem.title = "Club Wheat"
                       self.textView.text = clubText
                       //self.navigationController?.navigationBar.barTintColor = UIColor.yellow
                       //self.navigationController?.navigationBar.isTranslucent = false
                       }
               }
           
           })
           let handler = VNImageRequestHandler(ciImage: image)
           
           do {
               try handler.perform([request])
           }
           catch {
               print(error)
           }
       }
           

       

       
         
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           
           let resizedimage = image?.resize(255,255)
           
           imageView.image = resizedimage
           
               self.dismiss(animated: true, completion: nil)
              // self.imagePicker = [[GKImagePicker alloc]init]
               //
              // self.imagePicker.delegate = self
              // [self presentModalViewController:self.imagePicker.imagePickerController animated:YES]
          // self.imagePicker.cropSize = CGSizeMake(255,255)
           guard let ciImage = CIImage(image: resizedimage!) else {
                   fatalError("couldn't convert uiimage to CIImage")
               }
           print(info)
           detect(image: ciImage)
           //recognizeImage(image: resizedimage)
           }
       

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        //let imagePickerController = UIImagePickerController()
        imagePicker.allowsEditing = false
        //imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = .camera //.photoLibrary or .camera
   
        //imagePickerController.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photoTapped(_ sender: UIBarButtonItem) {
        //let imagePickerController = UIImagePickerController()
        imagePicker.allowsEditing = false
        //imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = .photoLibrary //.photoLibrary or .camera
   
        //imagePickerController.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
 
}

   // Helper function inserted by Swift 4.2 migrator.
   fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
       return input.rawValue
   }



