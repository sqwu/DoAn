//
//  SignIn.swift
//  HYCES v2.0
//
//  Created by Duong Le on 07/09/2021.
//

import UIKit
import Firebase
import ProgressHUD
import RealmSwift

class SignIn: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpBtt: UIButton!
    @IBOutlet weak var signInBtt: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    let taikhoan = TaiKhoan()
    override func viewDidLoad() {
   //     print(Realm.Configuration.defaultConfiguration.fileURL!)
        hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
        UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
        signInBtt.backgroundColor = UIColor(red: 0.38, green: 0.38, blue: 0.62, alpha: 1.00)
        signUpBtt.backgroundColor = UIColor(red: 0.64, green: 0.63, blue: 0.87, alpha: 1.00)
        errorLabel.isHidden = true
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
//        try! realm.write{let abc = realm.objects(TaiKhoan.self)
//            realm.delete(abc[6])
//                                }
        print(realm.objects(TaiKhoan.self))
        }


        func checkCoTaiKhoanChua () {
            guard let user = Auth.auth().currentUser else {return}
            if realm.objects(TaiKhoan.self).count == 0 {
                let predicate = NSPredicate(format: "id contains %@", user.uid as CVarArg)
                let chonXeList = realm.objects(ChonXe.self).filter(predicate)
                taikhoan.xe.append(objectsIn: chonXeList)
                taikhoan.id = user.uid
                taikhoan.email = user.email!
                taikhoan.name = user.displayName ?? ""
                taikhoan.photo = ""
              taikhoan.diemDau = 0
              taikhoan.diemCuoi = 1
              taikhoan.alpha = 1
                try! realm.write {
                    realm.add(taikhoan)
            }
            }
            else {
            for i in 0...realm.objects(TaiKhoan.self).count - 1 {
                if realm.objects(TaiKhoan.self)[i].id == user.uid {
                    try! realm.write{
                        realm.objects(TaiKhoan.self)[i].email = user.email!
                        realm.objects(TaiKhoan.self)[i].name = user.displayName ?? ""
                        realm.objects(TaiKhoan.self)[i].photo = ""
                    }
                    return} else {continue }
        }
//            let predicate = NSPredicate(format: "id contains %@", user.uid as CVarArg)
//            let chonXeList = realm.objects(ChonXe.self).filter(predicate)
                  taikhoan.id = user.uid
                  taikhoan.email = user.email!
                  taikhoan.name = user.displayName ?? ""
                  taikhoan.photo = ""
                taikhoan.diemDau = 0
                taikhoan.diemCuoi = 1
                taikhoan.alpha = 1
//            taikhoan.xe.append(objectsIn: chonXeList)
            try! realm.write {
                realm.add(taikhoan)
            }
            }

        }
    @IBAction func signUpDidTap(_ sender: UIButton) {
        let vc = SignUpVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func goToTrangChuVC(_ sender: UIButton) {
        //    hoa@gmail.com , 123456
            //dung@gmail.com , 123456
        // hoang@yahoo.com 123456
        // duongle@gmail.com 123456
//    Auth.auth().signIn(withEmail: "duongle@gmail.com", password: "123456") { authDataResult, error in}
//
//        checkCoTaiKhoanChua()
//        print(realm.objects(TaiKhoan.self))
//
//        let vc = TrangChuVC()
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//        }
//        addChonXeMoi(hangXe: "Chọn Hãng Xe", loaiXe: "Chọn Loại Xe", namSanXuat: "Chọn Năm Sản Xuất", khoangGia: "Chọn Khoảng giá", phienBan: "Chọn phiên bản", giaBan: 0, mau: "", soKmDaDi: "0", xuatXu: "", tinhTrang: "", hinhAnh1: "", hinhAnh2: "", hinhAnh3: "", hinhAnh4: "", hinhAnh5: "", hinhAnh6: "", tieuDe: "", thoiGianDang: "", diaDiem: "", taiKhoanDang: "", moiHayCu: "", anHien: "hien", banHayChua: "chua")
//


        
            if isValidInformantion() == true {
     ProgressHUD.show()
            Auth.auth().signIn(withEmail: self.emailTF.text!, password: self.passwordTF.text!) { authDataResult, error in

                if authDataResult != nil {
                    self.checkCoTaiKhoanChua()
                            print(realm.objects(TaiKhoan.self))
                    let vc = TrangChuVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
            }
                else
                {self.errorLabel.text = "Tài khoản không có"
                    self.errorLabel.textColor = .red
                    self.errorLabel.isHidden = false
                }

        }
                ProgressHUD.dismiss()
    }
        print("""

hiện tại là1 \(currentUser1?.email!)
ko theo là. \(Auth.auth().currentUser?.email)

""")
    }

    
  func isValidInformantion() -> Bool {
        if emailTF.text!.isEmpty || passwordTF.text!.isEmpty {
            errorLabel.isHidden = false
            errorLabel.textColor = .red
            errorLabel.text = "Chưa nhập Email và Password"
            return false
        }

        else if isValidEmail(emailTF.text!) == false {
            errorLabel.isHidden = false
            errorLabel.textColor = .red
            errorLabel.text = "Email không đúng"
            return false
        }
        else if isPasswordHasSixCharacter(password: passwordTF.text!) == false {
            errorLabel.isHidden = false
            errorLabel.textColor = .red
            errorLabel.text = "Password phải có ít nhất 6 ký tự"
            return false
        }
        // TODO valid email , password = confirm password ...ect...
        return true
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isPasswordHasSixCharacter(password: String) -> Bool {
        let passWordRegEx = "^.{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }



}
