//
//  SignUpVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 07/09/2021.
//

import UIKit
import  Firebase
import ProgressHUD
class SignUpVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpBtt: UIButton!
    @IBOutlet weak var backBtt: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
        UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
        signUpBtt.backgroundColor = UIColor(red: 0.38, green: 0.38, blue: 0.62, alpha: 1.00)
        errorLabel.isHidden = true
        backBtt.setTitleColor(.black, for: .normal)
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        emailTF.layer.borderWidth = 1
        emailTF.layer.borderColor = UIColor.lightGray.cgColor
        confirmPasswordTF.layer.borderWidth = 1
        confirmPasswordTF.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBAction func backToSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpDidTap(_ sender: UIButton) {
        if isValidInformantion() == true {
            ProgressHUD.show()
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!)  { authResult, error in }
            errorLabel.textColor = .green
            errorLabel.text = "Đăng ký thành công"
            errorLabel.isHidden = false
            ProgressHUD.dismiss()
        }
    }
    
    func isValidInformantion() -> Bool {
          if emailTF.text!.isEmpty || passwordTF.text!.isEmpty || confirmPasswordTF.text!.isEmpty {
              errorLabel.isHidden = false
              errorLabel.textColor = .red
              errorLabel.text = "Chưa nhập Email và Password"
              return false
          }
          else if passwordTF.text != confirmPasswordTF.text {
              errorLabel.isHidden = false
              errorLabel.textColor = .red
              errorLabel.text = "Mật khẩu không trùng khớp"
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
