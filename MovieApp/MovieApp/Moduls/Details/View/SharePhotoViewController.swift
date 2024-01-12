//
//  SharePhotoViewController.swift
//  MovieApp
//
//  Created by Nikita Shirobokov on 12.01.24.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
class SharePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var myImageView: UIImageView!
    var showImagePicketButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupImagePickerButton()
        
        setupImageView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupImagePickerButton()
    {
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
 
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        let xPostion:CGFloat = (screenWidth/2)-(buttonWidth/2)
        let yPostion:CGFloat = 70
        
        button.frame = CGRectMake(xPostion, yPostion, buttonWidth, buttonHeight)
        
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Select photo", for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(SharePhotoViewController.displayImagePickerButtonTapped) , for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupImageView()
    {
        myImageView = UIImageView()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let imageWidth:CGFloat = 200
        let imageHeight:CGFloat = 200
        
        let xPostion:CGFloat = (screenWidth/2) - (imageWidth/2)
        let yPostion:CGFloat = 100
        
        myImageView.frame = CGRectMake(xPostion, yPostion, imageWidth, imageHeight)
        
        self.view.addSubview(myImageView)
        
        
    }
    
    @objc func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any])
        {
            myImageView.image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue) ] as? UIImage
            myImageView.backgroundColor = UIColor.clear
            myImageView.contentMode = UIView.ContentMode.scaleAspectFit
            self.dismiss(animated: true, completion: nil)
            
            guard let image = info[.originalImage] as? UIImage else {
                    // handle and return
                    return
                }
            
            let photo:SharePhoto = SharePhoto(image: image, isUserGenerated: true)
     
            photo.image = myImageView.image
//            photo.userGenerated = true
            
            let content:SharePhotoContent = SharePhotoContent()
            content.photos = [photo]
            
            let shareButton = FBShareButton()
            shareButton.center = view.center
            
            shareButton.shareContent = content
            
            shareButton.center = self.view.center
            self.view.addSubview(shareButton)
            
        }
}
