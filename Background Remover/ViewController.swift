import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        designInit()
    }
    
    func designInit() {
        imgView.layer.cornerRadius = 8
        removeBtn.layer.cornerRadius = 25
        selectBtn.layer.cornerRadius = 15
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let img = info[.originalImage] as! UIImage
        imgView.image = img
    }
    
    @IBAction func removeBackgroundAction(_ sender: Any) {
        if imgView.image != nil {
            if let cgImg = imgView.image!.segmentation(){
                let filter = GraySegmentFilter()
                filter.inputImage = CIImage.init(cgImage: (imgView.image?.cgImage!)!)
                filter.maskImage = CIImage.init(cgImage: cgImg)
                let output = filter.value(forKey:kCIOutputImageKey) as! CIImage
                let ciContext = CIContext(options: nil)
                let cgImage = ciContext.createCGImage(output, from: output.extent)!
                imgView.image = UIImage(cgImage: cgImage)
            }
        }
    }
}

