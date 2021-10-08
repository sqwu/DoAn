//
//  SuaTaiKhoanVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 17/09/2021.
//

import UIKit
import Firebase
import Photos
import FirebaseStorage
import FirebaseUI

class SuaTaiKhoanVC: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var backBtt: UIButton!
    @IBOutlet weak var suaTenBtt: UIButton!
    @IBOutlet weak var suaMatKhauBtt: UIButton!
    @IBOutlet weak var suaDienThoaiBtt: UIButton!
    @IBOutlet weak var suaTenTextField: UITextField!
    @IBOutlet weak var suaMatKhauTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var moiBtt: UIButton!
    @IBOutlet weak var coDienBtt: UIButton!
    @IBOutlet weak var changeAvatarBtt: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var suaDienThoaiTextField: UITextField!
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var chiTietView: UIView!
    @IBOutlet weak var giaoDienView: UIView!
    @IBOutlet weak var chinhHinhNenView: UIView!
    @IBOutlet weak var chinhHinhNenBtt: UIButton!
    
    @IBOutlet weak var gradientView: Gradient!
    var imagePickerController = UIImagePickerController()
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        checkPermissions()
        hideKeyboardWhenTappedAround()
        setUiviewBorder(uiview: avatarView)
        setUiviewBorder(uiview: giaoDienView)
        setUiviewBorder(uiview: chiTietView)
        moiBtt.setTitleColor(.black, for: .normal)
        coDienBtt.setTitleColor(.white, for: .normal)
        if realm.objects(ColorClass.self).count == 0 {
            gradientView.startColor = mau1
            gradientView.endColor = mau2
        } else {
            let abcd = realm.objects(ColorClass.self)[0]
            gradientView.startColor = UIColor(red: CGFloat(abcd.colorComponents[0]), green: CGFloat(abcd.colorComponents[1]), blue: CGFloat(abcd.colorComponents[2]), alpha: CGFloat(abcd.colorComponents[3]))
            let abcd1 = realm.objects(ColorClass.self)[1]
            gradientView.endColor = UIColor(red: CGFloat(abcd1.colorComponents[0]), green: CGFloat(abcd1.colorComponents[1]), blue: CGFloat(abcd1.colorComponents[2]), alpha: CGFloat(abcd1.colorComponents[3]))
        }
        

    gradientView.startLocation = abc1!.diemDau
    gradientView.endLocation = abc1!.diemCuoi
    gradientView.alpha = CGFloat(abc1!.alpha)
        
        
        if let user = Auth.auth().currentUser {  suaTenTextField.text = user.displayName
            emailLabel.text = user.email
            emailLabel.textColor = .systemTeal
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //MARK: Set Avatar cho acount khi load
        var ref = storageRef.child("Avatar/\(Auth.auth().currentUser?.email ?? "")")
        ref.downloadURL(completion: { (url, error) in
                            if (error == nil) {
                                self.avatarImage.sd_setImage(with: url, completed: nil)
                                }
                             else {
                           // Do something if error
                            }
        }
        )
    
        
        //MARK: Set màu giao diện khi load
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            super.view.backgroundColor = .white
            wallPaperImgView.isHidden = true
            wallPaperImgView.alpha = wallpaperAlpha
            gradientView.isHidden = false
            chinhHinhNenView.isHidden = false
            super.view.backgroundColor = .white
            avatarView.backgroundColor = .white
            chiTietView.backgroundColor = .white
            giaoDienView.backgroundColor = .white
            topView.backgroundColor = .clear
            UILabel.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).textColor = .black
            UITextField.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).textColor = .black
            UIButton.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).setTitleColor(.black, for: .normal)
//            UIView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .lightGray
        }
        else {
            super.view.backgroundColor = .black
            wallPaperImgView.isHidden = true
            super.view.backgroundColor = .black
            gradientView.isHidden = true
            chinhHinhNenView.isHidden = true
            avatarView.backgroundColor = grayBackground
            chiTietView.backgroundColor = grayBackground
            giaoDienView.backgroundColor = grayBackground
            topView.backgroundColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).textColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).backgroundColor = .black
            UITextField.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).textColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [SuaTaiKhoanVC.self]).setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func backToTaiKhoanVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func suaTenDidTap(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = suaTenTextField.text
        changeRequest?.commitChanges{error in}

    }
    
    @IBAction func suaDienThoaiDidTap(_ sender: Any) {

    }
    
    @IBAction func suaMatKhauDidTap(_ sender: Any) {
        if let abc = suaMatKhauTF.text {
 Auth.auth().currentUser?.updatePassword(to: abc, completion: {error in})
        }
        else {return
            print("chưa thành công")
        }
    }
    
    @IBAction func moiBttDidTap(_ sender: Any) {
        chinhHinhNenView.isHidden = false
        try! realm.write{
            abc1?.theme = 0}
        moLaiSuaTaiKhoanVC = 1
        self.dismiss(animated: true, completion: nil)
}
    
    
    @IBAction func coDienBttDidTap(_ sender: Any) {
        chinhHinhNenView.isHidden = true
        try! realm.write{
            abc1?.theme = 1
    }
        moLaiSuaTaiKhoanVC = 1
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chinhHinhNenDidTap(_ sender: Any) {
        chinhHinhNen = 1
        let VC = TrangChuVC()
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .crossDissolve
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func changeAvatarDidTap(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated:  true, completion:  nil)
    }
    

    
    
    //MARK: Kiểm tra có được truy cập photo library ko
    func checkPermissions() {
       if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
                                PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                                    ()
                                })
                            }

                            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
                            } else {
                                PHPhotoLibrary.requestAuthorization(requestAuthroizationHandler)
                            }
    }
    
    func requestAuthroizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("We have access to photos")
        } else {
            print("We dont have access to photos")
        }
    }
    //-------------------------
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
            uploadToCloud(fileURL: url)
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    //MARK: hàm upload ảnh
    func uploadToCloud(fileURL : URL) {
        let data = Data()
        let localFule = fileURL
        
            var photoRef =  storageRef.child("Avatar/\(Auth.auth().currentUser?.email ?? "")")
            
            let uploadTask = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
                guard let metadata = metadata else {
                    print(err?.localizedDescription)
                    return
                }
                print("Photo Upload")
            }
        
    
    }
    
}


