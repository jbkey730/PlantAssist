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


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var seedImagelb: UILabel!
 
    @IBOutlet weak var modelPicker: UIPickerView!
    
    @IBOutlet weak var textView: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //model picker
    let models = ["Club","Inception","Sorghum","PlantID"]
    

    func numberOfComponents(in modelPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ modelPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return models.count
    }
    
    func pickerView(_ modelPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return models[row]
    }
    
    var selectedModel: String = ""

    func pickerView(_ modelPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedModel = models[row]
    }
    
    //image picker
       let imagePicker = UIImagePickerController()
       var classificationResults : [VNClassificationObservation] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           self.tabBarController?.navigationItem.titleView?.removeFromSuperview()
//           self.tabBarController?.navigationItem.title?.removeAll()
           //modelPicker.delegate = self
           //modelPicker.dataSource = self
           
           imagePicker.delegate = self
           
       }

           
   func detect(image: CIImage) {
       //var imageCropAndScaleOption: VNImageCropAndScaleOption = .scaleFill
       //let selectedmodel: String
       
//       guard let model = try? VNCoreMLModel(for: <#T##MLModel#>) else{
//           fatalError("Can't load ML model")
//       }
//
//       func getModelType() -> VNCoreMLModel {
       
    switch selectedModel {

       case "Club":
           //Load the ML model through its generated class
           guard let model = try? VNCoreMLModel(for: club(configuration: MLModelConfiguration()).model) else {
           fatalError("can't load ML model")
           }
           
           //get the result from the model
           let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
        
               let topResult = results.first
               else{
                   fatalError("unexpected result type from VNCoreMLRequest")
               }
               
               //club function
               mlResults.clubResult(topResult, self.seedImagelb)
           })
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
       case "Inception":
           //Load the ML model through its generated class
            guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model) else {
               fatalError("can't load ML model")
               }
        //get the result from the model
        let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
     
            let topResult = results.first
            else{
                fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            //club function
            mlResults.inceptionResult(topResult, self.seedImagelb)
        })
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
       case "Sorghum":
           //Load the ML model through its generated class
           guard let model = try? VNCoreMLModel(for: club(configuration: MLModelConfiguration()).model) else {
               fatalError("can't load ML model")
               }
        //get the result from the model
        let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
     
            let topResult = results.first
            else{
                fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            //club function
            mlResults.clubResult(topResult, self.seedImagelb)
        })
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
       case "PlantID":
           //Load the ML model through its generated class
           guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model) else {
               fatalError("can't load ML model")
               }
        //get the result from the model
        let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
     
            let topResult = results.first
            else{
                fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            //club function
            mlResults.inceptionResult(topResult, self.seedImagelb)
        })
        
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
       default:

          guard let model = try? VNCoreMLModel(for: club(configuration: MLModelConfiguration()).model) else {
               fatalError("can't load ML model")
               }
               //get the result from the model
               let request = VNCoreMLRequest(model: model, completionHandler: { (vnrequest, error) in guard let results = vnrequest.results as? [VNClassificationObservation],
            
                   let topResult = results.first
                   else{
                       fatalError("unexpected result type from VNCoreMLRequest")
                   }
               
                   //club function
                   mlResults.clubResult(topResult, self.seedImagelb)
            })
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
} //end detect function

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
           
           let resizedimage = image?.resize(512,512)
           
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



