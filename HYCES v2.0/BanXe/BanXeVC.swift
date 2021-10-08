//
//  BanXeVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 07/09/2021.
//
import Foundation
import UIKit
import RealmSwift
import Photos
import BSImagePicker
import MessageKit
import Firebase

class BanXeVC: UIViewController {
    @IBOutlet weak var backBtt: UIButton!
    
    @IBOutlet weak var chonHangXeBtt: UIButton!
    @IBOutlet weak var chonLoaiXeBtt: UIButton!
    @IBOutlet weak var chonNamSanXuatBtt: UIButton!
    @IBOutlet weak var chonPhienBanBtt: UIButton!
    
    @IBOutlet weak var upLoadHinhAnhBtt: UIButton!
    @IBOutlet weak var xuatXuBtt: UIButton!
    @IBOutlet weak var mauSacbtt: UIButton!
    @IBOutlet weak var moiBtt: UIButton!
    @IBOutlet weak var cuBtt: UIButton!
    
    @IBOutlet weak var banTuDongBtt: UIButton!
    @IBOutlet weak var soSanBtt: UIButton!
    @IBOutlet weak var tuDongBtt: UIButton!
    @IBOutlet weak var xangBtt: UIButton!
    @IBOutlet weak var daubtt: UIButton!
    @IBOutlet weak var hybridBtt: UIButton!
    @IBOutlet weak var resetHopSoBtt: UIButton!
    @IBOutlet weak var resetNhienLieu: UIButton!
    @IBOutlet weak var resetTinhTrang: UIButton!
    
    @IBOutlet weak var giaBanTextField: UITextField!
    @IBOutlet weak var soKmDaDiTextField: UITextField!
    @IBOutlet weak var tieuDeTinTextField: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var dangTinBtt: UIButton!
    @IBOutlet weak var xemTruocBtt: UIButton!
    
    @IBOutlet weak var chiTietTinDangTxView: UITextView!
    var imageArray = [UIImage]()
    var n: Int!
    
    var tableViewPhienBan: UITableView!
    var chonPhienBanIsState: Bool = true
    var tableViewXuatXu: UITableView!
    var chonXuatXuIsState: Bool = true
    var tableViewMauSac: UITableView!
    var chonMauSacIsState: Bool = true
    
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var hangXeLabel: UILabel!
    @IBOutlet weak var loaiXeLabel: UILabel!
    @IBOutlet weak var namSanXuatLabel: UILabel!
    @IBOutlet weak var phienBanLabel: UILabel!
    @IBOutlet weak var giaBanLabel: UILabel!
    @IBOutlet weak var soKmDaDiLabel: UILabel!
    @IBOutlet weak var tieuDeLabel: UILabel!
    
    @IBOutlet weak var gradientView: Gradient!
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        pushKeyboardUp()
        //        addChonXeMoi(hangXe: "Chọn Hãng Xe", loaiXe: "Chọn Loại Xe", namSanXuat: "Chọn Năm Sản Xuất", khoangGia: "Chọn Khoảng giá", phienBan: "Chọn phiên bản", giaBan: 0, mau: "", soKmDaDi: "0", xuatXu: "", tinhTrang: "", hinhAnh1: "", hinhAnh2: "", hinhAnh3: "", hinhAnh4: "", hinhAnh5: "", hinhAnh6: "", tieuDe: "", thoiGianDang: "", diaDiem: "", taiKhoanDang: "", moiHayCu: "", anHien: "hien", banHayChua: "chua")
        
    
        
        //                try! realm.write{
        //                    realm.delete(cacThuocTinhChonXeBan[1])
        //                }
        image.isHidden = false
        chiTietTinDangTxView.delegate = self
//        chiTietTinDangTxView.textColor = .lightGray
        self.hideKeyboardWhenTappedAround()
        
        chiTietTinDangTxView.text = "Mô tả chi tiết*"
        chiTietTinDangTxView.textColor = UIColor.lightGray
        
        tableViewXuatXu = {
            let tb = UITableView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .white
            tb.delegate = self
            tb.dataSource = self
            tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tb
        }()
        
        tableViewMauSac = {
            let tb = UITableView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .white
            tb.delegate = self
            tb.dataSource = self
            tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tb
        }()
        
        tableViewPhienBan = {
            let tb = UITableView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .white
            tb.delegate = self
            tb.dataSource = self
            tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tb
        }()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        //MARK: set Gradient View
        setGradientView(View: gradientView)
        
        //MARK: Set theme
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            wallPaperImgView.alpha = wallpaperAlpha
            wallPaperImgView.isHidden = true
            bottomImg.isHidden = true
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
//            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.black, for: .normal)
            image.image = UIImage(named: "picture")
            hangXeLabel.backgroundColor = .white
            loaiXeLabel.backgroundColor = .white
            namSanXuatLabel.backgroundColor = .white
            phienBanLabel.backgroundColor = .white
            hangXeLabel.textColor = .black
            loaiXeLabel.textColor = .black
            namSanXuatLabel.textColor = .black
            phienBanLabel.textColor = .black
            backBtt.backgroundColor = .clear
            resetNhienLieu.backgroundColor = .clear
            resetTinhTrang.backgroundColor = .clear
            resetHopSoBtt.backgroundColor = .clear
            xemTruocBtt.backgroundColor = UIColor(red: 0.64, green: 0.63, blue: 0.87, alpha: 1.00)
            
            
        }
        else { bottomImg.isHidden = true
            wallPaperImgView.isHidden = true
            super.view.backgroundColor = .black
            gradientView.isHidden = true
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
//            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
            image.image = UIImage(named: "picture2")
            hangXeLabel.backgroundColor = grayBackground
            loaiXeLabel.backgroundColor = grayBackground
            namSanXuatLabel.backgroundColor = grayBackground
            phienBanLabel.backgroundColor = grayBackground
            hangXeLabel.textColor = .white
            loaiXeLabel.textColor = .white
            namSanXuatLabel.textColor = .white
            phienBanLabel.textColor = .white
            backBtt.backgroundColor = .clear
            resetNhienLieu.backgroundColor = .clear
            resetTinhTrang.backgroundColor = .clear
            resetHopSoBtt.backgroundColor = .clear
            xemTruocBtt.backgroundColor = .white
            xemTruocBtt.setTitleColor(.black, for: .normal)
        }
    }
    
    //MARK:  fetchData
    func fetchData() {
        
        chonHangXeBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].hangXe)", for: .normal)
        chonLoaiXeBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].loaiXe)", for: .normal)
        chonNamSanXuatBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].namSanXuat)", for: .normal)
        chonPhienBanBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].phienBan)", for: .normal)
    }
    
    
    @objc func deleteCell(_ sender: UIButton) {
        collectionView.reloadData()
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) 
        else {return}
        collectionView.deleteItems(at: [IndexPath(row: indexPath.row, section: 0)])
        collectionView.reloadData()
        n -= 1
        
    }
    
    
    
    //MARK: setup các button để chọn các thông số của xe cần bán
    @IBAction func chonHangXeDidTap(_ sender: Any) {
        chonHangXeSua = 1
        let chonHangXeBanVC = ChonHangXeBan()
        chonHangXeBanVC.modalPresentationStyle = .fullScreen
        self.present(chonHangXeBanVC, animated: true, completion: nil)
        
    }
    
    @IBAction func chonLoaiXeDidTap(_ sender: Any) {
        if cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].hangXe == "Chọn Hãng Xe" {
            showAlertAction(title: "Lưu ý", message: "Chưa chọn hãng xe")
        } else {
            chonLoaiXeTim = 1
            let chonLoaiXe = ChonLoaiXeBan()
            chonLoaiXe.modalPresentationStyle = .fullScreen
            self.present(chonLoaiXe, animated: true, completion: nil)
        }
    }
    
    @IBAction func chonNamSanXuatDidTap(_ sender: Any) {
        chonNamSanXuatTim = 1
        let chonNamSanXuat = ChonNamSanXuatBan()
        chonNamSanXuat.modalPresentationStyle = .fullScreen
        self.present(chonNamSanXuat, animated: true, completion: nil)
    }
    
    //MARK: Chọn xuất xứ, màu sắc, phiên bản did tap button
    @IBAction func chonPhienBanDidTap(_ sender: Any) {
        if chonPhienBanIsState == true {
            super.view.addSubview(tableViewPhienBan)
            tableViewPhienBan.topAnchor.constraint(equalTo: chonPhienBanBtt.bottomAnchor).isActive = true
            tableViewPhienBan.leadingAnchor.constraint(equalTo: chonPhienBanBtt.leadingAnchor).isActive = true
            tableViewPhienBan.trailingAnchor.constraint(equalTo: chonPhienBanBtt.trailingAnchor).isActive = true
            tableViewPhienBan.heightAnchor.constraint(equalToConstant: 300).isActive = true
        }
        else {
            tableViewPhienBan.removeFromSuperview()
        }
        chonPhienBanIsState = !chonPhienBanIsState
    }
    
    @IBAction func chonXuatXuDidTap(_ sender: Any) {
        
        if chonXuatXuIsState == true {
            super.view.addSubview(tableViewXuatXu)
            tableViewXuatXu.topAnchor.constraint(equalTo: xuatXuBtt.bottomAnchor).isActive = true
            tableViewXuatXu.leadingAnchor.constraint(equalTo: xuatXuBtt.leadingAnchor).isActive = true
            tableViewXuatXu.trailingAnchor.constraint(equalTo: xuatXuBtt.trailingAnchor).isActive = true
            tableViewXuatXu.heightAnchor.constraint(equalToConstant: 300).isActive = true
        }
        else {
            tableViewXuatXu.removeFromSuperview()
        }
        chonXuatXuIsState = !chonXuatXuIsState
    }
    
    @IBAction func chonMauSacDidTap(_ sender: Any) {
        if chonMauSacIsState == true {
            super.view.addSubview(tableViewMauSac)
            tableViewMauSac.topAnchor.constraint(equalTo: mauSacbtt.bottomAnchor).isActive = true
            tableViewMauSac.leadingAnchor.constraint(equalTo: mauSacbtt.leadingAnchor).isActive = true
            tableViewMauSac.trailingAnchor.constraint(equalTo: mauSacbtt.trailingAnchor).isActive = true
            tableViewMauSac.heightAnchor.constraint(equalToConstant: 300).isActive = true
        }
        else {
            tableViewMauSac.removeFromSuperview()
        }
        chonMauSacIsState = !chonMauSacIsState
        
    }
    
    @IBAction func editTextView(_ sender: Any) {
        textViewDidBeginEditing(chiTietTinDangTxView)
        chiTietTinDangTxView.becomeFirstResponder()
    }
    //MARK: Lưu xuất xứ, màu sắc, tình trạng, vào realmSwift
    func luuTaiKhoan() {
        if let user = Auth.auth().currentUser?.uid {
            let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
            try! Realm().write {
                abc.taiKhoan = user
            }}
        else {return}
        
    }
    
    func luuGiaBan(name: Int) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! Realm().write {
            abc.giaBan = name
        }
    }
    func luuSoKm(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.soKmDaDi = name
        }
    }
    func luuTieuDeTinDang(name: String) {
        
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.tieuDe = name
        }
    }
    func luuTinhTrang(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.tinhTrang = name
        }
    }
    func luuXuatXu(name: String) {
        
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.xuatXu = name
        }
        xuatXuBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].xuatXu)", for: .normal)
    }
    
    func luuMauSac(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.mau = name
        }
        mauSacbtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].mau)", for: .normal)
    }
    func luuThoiGian(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.thoiGianDang = name
        }
    }
    
    func luuDiaDiem(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.diaDiem = name
        }
    }
    func luuHopSo(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.hopSo = name
        }
    }
    
    func luuNhienLieu(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.nhienLieu = name
        }
    }
    func luuCuMoi(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.moiHayCu = name
        }
    }
    func luuPhienBan(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.phienBan = name
        }
        chonPhienBanBtt.setTitle(" \(cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].phienBan)", for: .normal)
    }
    //MARK: Đăng tin và kết thúc save vào realmSwift
    func luuHinhAnh(anh1: String, anh2: String, anh3: String, anh4: String, anh5: String, anh6: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.hinhAnh1 = anh1
            abc.hinhAnh2 = anh2
            abc.hinhAnh3 = anh3
            abc.hinhAnh4 = anh4
            abc.hinhAnh5 = anh5
            abc.hinhAnh6 = anh6
        }
    }
    //MARK: XEM TRƯỚC TAP
    @IBAction func xemTruocDidTap(_ sender: Any) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        if giaBanTextField.text == "" || soKmDaDiTextField.text == "" || tieuDeTinTextField.text == "" || abc.hangXe == "Chọn Hãng Xe" || abc.loaiXe == "Chọn Loại Xe" || abc.namSanXuat == "Chọn Năm Sản Xuất" || chiTietTinDangTxView.text == "Mô tả chi tiết*" || chiTietTinDangTxView.text == "" || abc.xuatXu == "" || abc.mau == "" {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")}
        else {
            
            let imageNameArray = getListOfImageName()
            luuHinhAnh(anh1: imageNameArray[0], anh2: imageNameArray[1], anh3: imageNameArray[2], anh4: imageNameArray[3], anh5: imageNameArray[4], anh6: imageNameArray[5])
            
            let chiTietTinDang = chiTietTinDangTxView.text!
            luuTinhTrang(name: chiTietTinDang)
            
            let giaBanText = Int(giaBanTextField.text!)
            luuGiaBan(name: giaBanText!)
            
            let soKm = soKmDaDiTextField.text!
            luuSoKm(name: soKm)
            
            let tieuDe = tieuDeTinTextField.text!
            luuTieuDeTinDang(name: tieuDe)
            
            luuThoiGian(name: getCurrentDate())
            luuDiaDiem(name: diaDiem.randomElement()!)
            luuTaiKhoan()
            chonLoaiXeTim = 1
            chonKhoangGiaTim = 1
            chonNamSanXuatTim = 1
            chonHangXeSua = 1
            let VC = ChiTietXeCuVC()
            VC.modalTransitionStyle = .crossDissolve
            VC.modalPresentationStyle = .fullScreen
            primaryKey = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].id
            dangTinState = 1
            
            self.present(VC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backToTrangChuVC(_ sender: Any) {
        
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            realm.delete(abc)}
        //        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: LƯU TẤT CẢ LẦN CUỐI KHI BẤM ĐĂNG TIN
    @IBAction func dangTinDidTap(_ sender: Any) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        if
//            giaBanTextField.text == "" || soKmDaDiTextField.text == "" || tieuDeTinTextField.text == "" || abc.hangXe == "Chọn Hãng Xe" || abc.loaiXe == "Chọn Loại Xe" || abc.namSanXuat == "Chọn Năm Sản Xuất" || chiTietTinDangTxView.text == "Mô tả chi tiết*" || chiTietTinDangTxView.text == "" || abc.xuatXu == "" || abc.mau == ""
            abc.hangXe == "Chọn Hãng Xe"
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
            hangXeLabel.textColor = .red}
        else if abc.loaiXe == "Chọn Loại Xe"
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
            loaiXeLabel.textColor = .red}
        else if abc.namSanXuat == "Chọn Năm Sản Xuất"
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
            namSanXuatLabel.textColor = .red}
        else if giaBanTextField.text == ""
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
           giaBanLabel.textColor = .red}
        else if soKmDaDiTextField.text == ""
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
           soKmDaDiLabel.textColor = .red}
        else if tieuDeTinTextField.text == ""
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
           tieuDeLabel.textColor = .red}
        else if chiTietTinDangTxView.text == "" || chiTietTinDangTxView.text == "Mô tả chi tiết*"
        {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")
           chiTietTinDangTxView.textColor = .red
            chiTietTinDangTxView.text = "Chi tiết tin đăng không được bỏ trống"
        }
        
        else {
            let imageNameArray = getListOfImageName()
            luuHinhAnh(anh1: imageNameArray[0], anh2: imageNameArray[1], anh3: imageNameArray[2], anh4: imageNameArray[3], anh5: imageNameArray[4], anh6: imageNameArray[5])
            
            let chiTietTinDang = chiTietTinDangTxView.text!
            luuTinhTrang(name: chiTietTinDang)
            
            let giaBanText = Int(giaBanTextField.text!)
            luuGiaBan(name: giaBanText!)
            
            let soKm = soKmDaDiTextField.text!
            luuSoKm(name: soKm)
            
            let tieuDe = tieuDeTinTextField.text!
            luuTieuDeTinDang(name: tieuDe)
            
            luuThoiGian(name: getCurrentDate())
            luuDiaDiem(name: diaDiem.randomElement()!)
            luuTaiKhoan()
            
            noiDungArray.insert("Chúc mừng bạn! Tin đăng \(abc.tieuDe) đã được duyệt thành công", at: 0)
            
            thoiGianArray.insert("\(abc.thoiGianDang.suffix(5))", at: 0)
            imageArrayTb.insert(UIImage(named: "avatar2")!, at: 0)
            idArray.insert("\(abc.id)", at: 0)
            thongBaoMoi += 1
            
            chonLoaiXeTim = 1
            chonKhoangGiaTim = 1
            chonNamSanXuatTim = 1
            chonHangXeSua = 1
            let vc = TrangChuVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    //MARK: Change Button State
    @IBAction func resetTinhTrangXeDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            cuBtt.backgroundColor = .white
            moiBtt.backgroundColor = .white
        }
        else {
            cuBtt.backgroundColor = grayBackground
            moiBtt.backgroundColor = grayBackground
        }
        luuCuMoi(name: "")
    }
    
    @IBAction func resetNhienLieuDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            daubtt.backgroundColor = .white
            hybridBtt.backgroundColor = .white
            xangBtt.backgroundColor = .white
        }
        else {
            daubtt.backgroundColor = grayBackground
            hybridBtt.backgroundColor = grayBackground
            xangBtt.backgroundColor = grayBackground
        }
        luuNhienLieu(name: "")
    }
    @IBAction func resetHopSoDidTap(_ sender: Any) {
        
        if abc1?.theme == 0 {
            banTuDongBtt.backgroundColor = .white
            soSanBtt.backgroundColor = .white
            tuDongBtt.backgroundColor = .white
        }
        else {
            banTuDongBtt.backgroundColor = grayBackground
            soSanBtt.backgroundColor = grayBackground
            tuDongBtt.backgroundColor = grayBackground
        }
        luuHopSo(name: "")
    }
    
    @IBAction func changeTuDongState(_ sender: Any) {
        if abc1?.theme == 0 {
            banTuDongBtt.backgroundColor = .white
            soSanBtt.backgroundColor = .white
            tuDongBtt.backgroundColor = .lightGray
        }
        else {
            banTuDongBtt.backgroundColor = grayBackground
            soSanBtt.backgroundColor = grayBackground
            tuDongBtt.backgroundColor = .lightGray
        }
        luuHopSo(name: "Tự Động")
    }
    @IBAction func changeSoSanState(_ sender: Any) {
        if abc1?.theme == 0 {
            banTuDongBtt.backgroundColor = .white
            tuDongBtt.backgroundColor = .white
            soSanBtt.backgroundColor = .lightGray
        }
        else {
            banTuDongBtt.backgroundColor = grayBackground
            tuDongBtt.backgroundColor = grayBackground
            soSanBtt.backgroundColor = .lightGray
        }
        luuHopSo(name: "Số Sàn")
    }
    @IBAction func changeBanTuDongState(_ sender: Any) {
        if abc1?.theme == 0 {
            tuDongBtt.backgroundColor = .white
            soSanBtt.backgroundColor = .white
            banTuDongBtt.backgroundColor = .lightGray
        }
        else {
            tuDongBtt.backgroundColor = grayBackground
            soSanBtt.backgroundColor = grayBackground
            banTuDongBtt.backgroundColor = .lightGray
        }
        luuHopSo(name: "Bán Tự Động")
    }
    @IBAction func xangBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            daubtt.backgroundColor = .white
            hybridBtt.backgroundColor = .white
            xangBtt.backgroundColor = .lightGray
        }
        else {
            daubtt.backgroundColor = grayBackground
            hybridBtt.backgroundColor = grayBackground
            xangBtt.backgroundColor = .lightGray
        }
        luuNhienLieu(name: "Xăng")
    }
    @IBAction func dauBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            xangBtt.backgroundColor = .white
            hybridBtt.backgroundColor = .white
            daubtt.backgroundColor = .lightGray
        }
        else {
            xangBtt.backgroundColor = grayBackground
            hybridBtt.backgroundColor = grayBackground
            daubtt.backgroundColor = .lightGray
        }
        luuNhienLieu(name: "Dầu")
    }
    @IBAction func hybridBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            daubtt.backgroundColor = .white
            xangBtt.backgroundColor = .white
            hybridBtt.backgroundColor = .lightGray
        }
        else {
            daubtt.backgroundColor = grayBackground
            xangBtt.backgroundColor = grayBackground
            hybridBtt.backgroundColor = .lightGray
        }
        luuNhienLieu(name: "Hybrid")
    }
    @IBAction func moiBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            cuBtt.backgroundColor = .white}
        else {cuBtt.backgroundColor = grayBackground}
        moiBtt.backgroundColor = .lightGray
        luuCuMoi(name: "Xe mới")
    }
    
    @IBAction func cuBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            moiBtt.backgroundColor = .white}
        else {moiBtt.backgroundColor = grayBackground}
        cuBtt.backgroundColor = .lightGray
        luuCuMoi(name: "Xe Cũ")
    }
    
    //MARK: Thay đổi số trong textfield thành có dấu chấm cách hàng nghìn
    @IBAction func giaBanTextFieldChange(_ sender: Any) {
        //        var newText = String()
        //        for (index, character) in giaBanTextField.text!.enumerated() {
        //                if index != 0 && index % 3 == 0 {
        //                    newText.append(".")
        //                }
        //                newText.append(String(character))
        //            }
        //        giaBanTextField.text = newText
        //       var array = Array(giaBanTextField.text!)
        //        for (index, character) in array.enumerated() {
        //            if character == "." { array.remove(at: index)
        //        }
        //        }
        //        giaBanTextField.text = String(array)
    }
    
    //MARK: Photos
    
    
    @IBAction func openPhoto(_ sender: Any) {
        let imagePicker = ImagePickerController()
        
        presentImagePicker(imagePicker, select: { (asset) in
            
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            self.image.isHidden = true
            self.collectionView.reloadData()
            self.imageArray = []
            self.imageArray = self.getAssetThumbnail(assets: assets)
            self.n = self.imageArray.count
            let nib = UINib(nibName: "UploadAnhXeCollectionViewCell", bundle: nil)
            self.collectionView.register(nib, forCellWithReuseIdentifier: "UploadAnhXeCollectionViewCell")
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
        })
    }
    //MARK: Show Alert
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.setMessage(font: UIFont.systemFont(ofSize: 16), color: .blue)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            return
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .blue
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Convert array of PHAsset in ImagePicker to UIImages
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }
        
        return arrayOfImages
    }
}


//MARK: CollectionView

extension BanXeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        n
        //imageArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadAnhXeCollectionViewCell", for: indexPath) as! UploadAnhXeCollectionViewCell
        cell.anhXeImgView.image = imageArray[indexPath.row]
        cell.deleteBtt.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
//MARK: TableView

extension BanXeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewXuatXu {return xuatXu.count}
        else if tableView == tableViewPhienBan {return phienBan.count}
        else {return mauSac.count}
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textColor = .black
        if tableView == tableViewXuatXu {cell.textLabel?.text = xuatXu[indexPath.row]}
        else if tableView == tableViewPhienBan {cell.textLabel?.text = phienBan[indexPath.row]}
        else {cell.textLabel?.text = mauSac[indexPath.row]}
        if abc1?.theme == 0 {
            cell.textLabel?.textColor = .black} else {
                cell.textLabel?.textColor = .white
            }
        nganDongView = {
            let tb = UIView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .systemTeal
            return tb
        }()
        cell.addSubview(nganDongView)
        nganDongView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -1).isActive = true
        nganDongView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10).isActive = true
        nganDongView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10).isActive = true
        nganDongView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewXuatXu {
            let name = xuatXu[indexPath.row]
            luuXuatXu(name: name)
            chonXuatXuIsState = !chonXuatXuIsState
            tableViewXuatXu.removeFromSuperview()
        }
        else if tableView == tableViewPhienBan {
            let name = phienBan[indexPath.row]
            luuPhienBan(name: name)
            chonPhienBanIsState = !chonPhienBanIsState
            tableViewPhienBan.removeFromSuperview()
        }
        
        else {
            let name1 = mauSac[indexPath.row]
            luuMauSac(name: name1)
            chonMauSacIsState = !chonMauSacIsState
            tableViewMauSac.removeFromSuperview()
        }
    }
    
}
//MARK: extension dismiss bàn phím ảo khi chạy trên iphone thật



extension BanXeVC: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if abc1?.theme == 0 {textView.text = "Mô tả chi tiết*"
                textView.textColor = UIColor.lightGray} else {
                    textView.text = "Mô tả chi tiết*"
                        textView.textColor = UIColor.lightGray
                }

            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            if abc1?.theme == 0 {textView.textColor = UIColor.black} else {textView.textColor = UIColor.white }
            
        }
    }
}
