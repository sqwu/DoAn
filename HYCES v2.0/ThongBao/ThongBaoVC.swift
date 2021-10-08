//
//  ThongBaoVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 14/09/2021.
//

import UIKit
import Firebase

class ThongBaoVC: UIViewController {
    @IBOutlet weak var thongBaoTableView: UITableView!
    @IBOutlet weak var trangChuBtt: UIButton!
    @IBOutlet weak var dangTinBtt: UIButton!
    @IBOutlet weak var thongBaoBtt: UIButton!
    @IBOutlet weak var backBtt: UIButton!
    @IBOutlet weak var taiKhoanBtt: UIButton!
    @IBOutlet weak var messageBtt: UIButton!

    @IBOutlet weak var thongBaoMoiLabel: UILabel!
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var bottomImg: UIImageView!
    var avatarImage: UIImageView!

    @IBOutlet weak var gradientView: Gradient!
    
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trangChuBtt.centerXAnchor.constraint(equalTo: super.view.leadingAnchor, constant: super.view.frame.width/5 - 30).isActive = true
        dangTinBtt.centerXAnchor.constraint(equalTo: trangChuBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
        thongBaoBtt.centerXAnchor.constraint(equalTo: dangTinBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
        taiKhoanBtt.centerXAnchor.constraint(equalTo: thongBaoBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true


        thongBaoTableView.delegate = self
        thongBaoTableView.dataSource = self
        let nib = UINib(nibName: "ThongBaoTableViewCell", bundle: nil)
        thongBaoTableView.register(nib, forCellReuseIdentifier: "ThongBaoTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        setGradientView(View: gradientView)
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            super.view.backgroundColor = .white
            wallPaperImgView.isHidden = true
            wallPaperImgView.alpha = wallpaperAlpha
            if damBottomImgState == true {
                bottomImg.isHidden = true
            } else { bottomImg.isHidden = false }
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.black, for: .normal)
        }
        else {
            super.view.backgroundColor = .black
            wallPaperImgView.isHidden = true
            gradientView.isHidden = true
            bottomImg.isHidden = true
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
        }
        setThongBaoMoi(label: thongBaoMoiLabel)
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToTaiKhoan(_ sender: Any) {
        taiKhoanState = 1
        let vc = TaiKhoanVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goToDangTin(_ sender: Any) {
        let vc = BanXeVC()
        chonLoaiXeTim = 1
        addChonXeMoi(hangXe: "Chọn Hãng Xe", loaiXe: "Chọn Loại Xe", namSanXuat: "Chọn Năm Sản Xuất", khoangGia: "Chọn Khoảng giá", phienBan: "Chọn phiên bản", giaBan: 0, mau: "", soKmDaDi: "0", xuatXu: "", tinhTrang: "", hinhAnh1: "", hinhAnh2: "", hinhAnh3: "", hinhAnh4: "", hinhAnh5: "", hinhAnh6: "", tieuDe: "", thoiGianDang: "", diaDiem: "", taiKhoanDang: "", moiHayCu: "", anHien: "hien", banHayChua: "chua")
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func goToTrangChu(_ sender: Any) {
        let vc = TrangChuVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func goToTinNhan(_ sender: Any) {
        let vc = ListMessageVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
extension ThongBaoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noiDungArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThongBaoTableViewCell", for: indexPath) as! ThongBaoTableViewCell
        if indexPath.row >= thongBaoMoi {
//            cell.backgroundColor = UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
            cell.chamTron.isHidden = true
        }
        cell.noiDungLabel.text = noiDungArray[indexPath.row]
        cell.thoiGianLabel.text = thoiGianArray[indexPath.row]
        cell.avatarImgView.image = imageArrayTb[indexPath.row]
        cell.idLabel.text = idArray[indexPath.row]
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! ThongBaoTableViewCell
        primaryKey = currentCell.idLabel.text!
        dangTinState = 3
        if thongBaoMoi > 0 {
            if indexPath!.row <= thongBaoMoi {

                thongBaoMoi -= 1
                thongBaoMoiLabel.text = "\(thongBaoMoi)"
            }
        }
        else {thongBaoMoi = 0}
        thongBaoTableView.reloadData()
if primaryKey != "0" && primaryKey != "1"  && primaryKey != "2"  && primaryKey != "3"  && primaryKey != "4" {
    let VC = ChiTietXeCuVC()
    VC.modalPresentationStyle = .fullScreen
    VC.modalTransitionStyle = . crossDissolve
    self.present(VC, animated: true, completion: nil)
    dangTinState = 3
    thongBaoTableView.reloadData()
}

    }

}



