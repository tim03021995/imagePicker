import UIKit

class ViewController: UIViewController{
    var cameraAvailable : Bool {
        get{
           return
       UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        }set{
           showImagePickerAvailableStateToLabel(newValue)
        }
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
//        var cameraAvailable = UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        let fullScreenSize = UIScreen.main.bounds.size; print(fullScreenSize)
        let defaultImage = #imageLiteral(resourceName: "5431.jpg")
        showImagePickerAvailableStateToLabel(cameraAvailable)//顯示全線測試結果
        imageSizeSet(image: myImageView, screenSize: fullScreenSize)//設置相片大小
        imageCenterSet(image: myImageView, screenSize: fullScreenSize)//相片中伈點設置
        myImageView.image = defaultImage//顯示圖片
        
        imagePicker.delegate = self
        super.viewDidLoad()
    }
    // MARK: - IBOutlet
    @IBOutlet weak var imagePickerAvailable: UILabel!
    let  imagePicker = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    // MARK: - IBAtion
    @IBAction func openCamara(_ sender: UIButton) {
        cameraAvailable=UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo
        imagePicker.cameraFlashMode = .off
        imagePicker.imageExportPreset = .compatible
        show(imagePicker, sender: self)
        print("Open Camera")
    }
    
    @IBAction func album(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        show(imagePicker, sender: self)
    }
    //MARK: - Funtion
    func CameraPermissionRequestAlertFuntion(){
        let cameraPermissionRequestAlert = UIAlertController(title: "相機權限", message: "是否允許該應用使用您的相機", preferredStyle: .alert)
        let yesRequestalert = UIAlertAction(title: "好的", style: .default){(_)in
            _ = URL (string: UIApplication.openSettingsURLString)
            print("允許相機")
            
        }
        let noRequestalert = UIAlertAction(title: "取消", style: .default){(_)in
            print("拒絕相機權限")
        }
        cameraPermissionRequestAlert.addAction(noRequestalert)
        cameraPermissionRequestAlert.addAction(yesRequestalert)
        present(cameraPermissionRequestAlert, animated: true)
    }//相機權限視窗
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            print("測試失敗")
//            return
//        }
//        cameraAvailable = true
    }//點擊螢幕開啟測試
    func showImagePickerAvailableStateToLabel(_ status:Bool){
        if status == true
        {
            imagePickerAvailable.text = "存在"
            imagePickerAvailable.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else{
            imagePickerAvailable.text = "不存在"
            imagePickerAvailable.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }//顯示測試結果
    func imageSizeSet(image: UIImageView,screenSize: CGSize){
        image.frame = CGRect (x: 0, y: 0,
        width: screenSize.width*0.9,
        height: screenSize.height*0.7)
    }//圖片大小調整
    func imageCenterSet(image: UIImageView, screenSize: CGSize){
               image.center = CGPoint(
                   x: screenSize.width*0.5,
                   y: screenSize.height*0.5
               )
           }//同片中心點設置
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Use photo")
        let image = info[.originalImage] as! UIImage//取得拍下的照片
        myImageView.image = image
        print("取得照片")
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)//將相片存擋
        print("照片存擋")
            dismiss(animated: true, completion: nil)
    }
}

