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

class BanXeVCSuaTin: UIViewController {
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

    
    @IBOutlet weak var chiTietTinDangTxView: UITextView!
    
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var hangXeLabel: UILabel!
    @IBOutlet weak var loaiXeLabel: UILabel!
    @IBOutlet weak var namSanXuatLabel: UILabel!
    @IBOutlet weak var phienBanLabel: UILabel!
    
    var imageArray = [UIImage]()
    var n: Int!
    
    @IBOutlet weak var gradientView: Gradient!
    
    var tableViewPhienBan: UITableView!
    var chonPhienBanIsState: Bool = true
    var tableViewXuatXu: UITableView!
    var chonXuatXuIsState: Bool = true
    var tableViewMauSac: UITableView!
    var chonMauSacIsState: Bool = true
    
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        pushKeyboardUp()

        
        suaHangXe = filterXeDangBan[indexOfFilterXeDangBan].hangXe
        suaLoaiXe = filterXeDangBan[indexOfFilterXeDangBan].loaiXe
        suaNamSanXuat = filterXeDangBan[indexOfFilterXeDangBan].namSanXuat
        suaPhienBan = filterXeDangBan[indexOfFilterXeDangBan].phienBan
        suaXuatXu = filterXeDangBan[indexOfFilterXeDangBan].xuatXu
        suaMauSac = filterXeDangBan[indexOfFilterXeDangBan].mau
        suaHopSo = filterXeDangBan[indexOfFilterXeDangBan].hopSo
        suaNhienLieu = filterXeDangBan[indexOfFilterXeDangBan].nhienLieu
        suaCuMoi = filterXeDangBan[indexOfFilterXeDangBan].moiHayCu
//        imageArray = [UIImage(named: filterXeDangBan[indexOfFilterXeDangBan].hinhAnh1)!, UIImage(named: filterXeDangBan[indexOfFilterXeDangBan].hinhAnh2)!, UIImage(named: filterXeDangBan[indexOfFilterXeDangBan].hinhAnh3)!]
     
        
        image.isHidden = false
        chiTietTinDangTxView.delegate = self
        
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
        setGradientView(View: gradientView)
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            wallPaperImgView.alpha = wallpaperAlpha
            super.view.backgroundColor = .white
            wallPaperImgView.isHidden = true
                       bottomImg.isHidden = true
            
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
          UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
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
//            tuDongBtt.backgroundColor = .lightGray
//            soSanBtt.backgroundColor = .lightGray
//            banTuDongBtt.backgroundColor = .lightGray
//            xangBtt.backgroundColor = .lightGray
//            daubtt.backgroundColor = .lightGray
//            hybridBtt.backgroundColor = .lightGray
//            cuBtt.backgroundColor = .lightGray
//            moiBtt.backgroundColor = .lightGray
        }
        else { bottomImg.isHidden = true
            wallPaperImgView.isHidden = true
            gradientView.isHidden = true
            super.view.backgroundColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UITextView.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white

            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
        //    UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
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

        }
    }
    
    //MARK:  fetchData
    func fetchData() {
        try! realm.write{
            filterXeDangBan[indexOfFilterXeDangBan].hangXe = suaHangXe
            filterXeDangBan[indexOfFilterXeDangBan].loaiXe = suaLoaiXe
        }
        chonHangXeBtt.setTitle(" \(suaHangXe)", for: .normal)
        chonLoaiXeBtt.setTitle(" \(suaLoaiXe)", for: .normal)
        chonNamSanXuatBtt.setTitle(" \(suaNamSanXuat)", for: .normal)
        chonPhienBanBtt.setTitle(" \(suaPhienBan)", for: .normal)
        xuatXuBtt.setTitle(" \(suaXuatXu)", for: .normal)
        mauSacbtt.setTitle(" \(suaMauSac)", for: .normal)
        giaBanTextField.text = "\(filterXeDangBan[indexOfFilterXeDangBan].giaBan)"
        soKmDaDiTextField.text = filterXeDangBan[indexOfFilterXeDangBan].soKmDaDi
        tieuDeTinTextField.text = filterXeDangBan[indexOfFilterXeDangBan].tieuDe
        chiTietTinDangTxView.text = filterXeDangBan[indexOfFilterXeDangBan].tinhTrang
        if suaHopSo == "Tự Động" {
            tuDongBtt.backgroundColor = .lightGray
        }
        else if suaHopSo == "Số Sàn" {
            soSanBtt.backgroundColor = .lightGray
        }
        else if suaHopSo == "Bán Tự Động" {
            banTuDongBtt.backgroundColor = .lightGray
        }
        if suaNhienLieu == "Xăng" {
            xangBtt.backgroundColor = .lightGray

        }
        else if suaNhienLieu == "Dầu" {
            daubtt.backgroundColor = .lightGray

        }
        else if suaNhienLieu == "Hybrid" {
            hybridBtt.backgroundColor = .lightGray
//            daubtt.backgroundColor = .darkGray
//            daubtt.setTitleColor(.white, for: .normal)
//            xangBtt.backgroundColor = .darkGray
//            xangBtt.setTitleColor(.white, for: .normal)
//            hybridBtt.backgroundColor = .white
//            hybridBtt.setTitleColor(.black, for: .normal)
        }
        
        if suaCuMoi == "Xe mới" {
        moiBtt.backgroundColor = .lightGray

//            cuBtt.backgroundColor = .darkGray
//            cuBtt.setTitleColor(.white, for: .normal)
//            moiBtt.backgroundColor = .white
//            moiBtt.setTitleColor(.black, for: .normal)
        }
        else if suaCuMoi == "Xe Cũ" {
            cuBtt.backgroundColor = .lightGray
//            moiBtt.backgroundColor = .darkGray
//            moiBtt.setTitleColor(.white, for: .normal)
//            cuBtt.backgroundColor = .white
//            cuBtt.setTitleColor(.black, for: .normal)
        }
        
    }
    
    //MARK: xoá ảnh trong collectionview
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
        chonHangXeSua = 3
        let chonHangXeBanVC = ChonHangXeBan()
        chonHangXeBanVC.modalPresentationStyle = .fullScreen
        self.present(chonHangXeBanVC, animated: true, completion: nil)
        
    }
    
    @IBAction func chonLoaiXeDidTap(_ sender: Any) {
        if filterXeDangBan[indexOfFilterXeDangBan].hangXe == "Chọn Hãng Xe" {
            showAlertAction(title: "Lưu ý", message: "Chưa chọn hãng xe")
        } else {
        chonLoaiXeTim = 3
        let chonLoaiXe = ChonLoaiXeBan()
        chonLoaiXe.modalPresentationStyle = .fullScreen
        self.present(chonLoaiXe, animated: true, completion: nil)
        }
    }
    
    @IBAction func chonNamSanXuatDidTap(_ sender: Any) {
        chonNamSanXuatTim = 3
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
    
    //MARK: Lưu xuất xứ, màu sắc, tình trạng, vào realmSwift

    func luuGiaBan(name: Int) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! Realm().write {
            abc.giaBan = name
        }
    }
    func luuSoKm(name: String) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! realm.write {
            abc.soKmDaDi = name
        }
    }
    func luuTieuDeTinDang(name: String) {
        
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! realm.write {
            abc.tieuDe = name
        }
    }
    func luuTinhTrang(name: String) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! realm.write {
            abc.tinhTrang = name
        }
    }

    


    

    func luuPhienBan(name: String) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! realm.write {
            abc.phienBan = name
        }
        chonPhienBanBtt.setTitle(" \(filterXeDangBan[indexOfFilterXeDangBan].phienBan)", for: .normal)
    }
    //MARK: Đăng tin và kết thúc save vào realmSwift
    func luuHinhAnh(anh1: String, anh2: String, anh3: String, anh4: String, anh5: String, anh6: String) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        try! realm.write {
            abc.hinhAnh1 = anh1
            abc.hinhAnh2 = anh2
            abc.hinhAnh3 = anh3
            abc.hinhAnh4 = anh4
            abc.hinhAnh5 = anh5
            abc.hinhAnh6 = anh6
        }
    }
 
    
    
    @IBAction func backToTrangChuVC(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
    //MARK: LƯU TẤT CẢ LẦN CUỐI KHI BẤM ĐĂNG TIN
    @IBAction func dangTinDidTap(_ sender: Any) {
        let abc = filterXeDangBan[indexOfFilterXeDangBan]
        if giaBanTextField.text == "" || soKmDaDiTextField.text == "" || tieuDeTinTextField.text == "" || abc.hangXe == "Chọn Hãng Xe" || abc.loaiXe == "Chọn Loại Xe"  || abc.namSanXuat == "Chọn Năm Sản Xuất" || chiTietTinDangTxView.text == "Mô tả chi tiết*" || chiTietTinDangTxView.text == "" || abc.xuatXu == "" || abc.mau == "" {showAlertAction(title: "Lưu ý", message: "Chưa điền đủ thông tin")}
        else {

            //|| suaLoaiXe == "Chọn Loại Xe"
        let chiTietTinDang = chiTietTinDangTxView.text!
        luuTinhTrang(name: chiTietTinDang)
        
        let giaBanText = Int(giaBanTextField.text!)
        luuGiaBan(name: giaBanText!)
        
        let soKm = soKmDaDiTextField.text!
        luuSoKm(name: soKm)
        
        let tieuDe = tieuDeTinTextField.text!
        luuTieuDeTinDang(name: tieuDe)
        
        try! realm.write{
            filterXeDangBan[indexOfFilterXeDangBan].hangXe = suaHangXe
            filterXeDangBan[indexOfFilterXeDangBan].loaiXe = suaLoaiXe
            filterXeDangBan[indexOfFilterXeDangBan].namSanXuat = suaNamSanXuat
            filterXeDangBan[indexOfFilterXeDangBan].phienBan = suaPhienBan
            filterXeDangBan[indexOfFilterXeDangBan].mau = suaMauSac
            filterXeDangBan[indexOfFilterXeDangBan].xuatXu = suaXuatXu
            filterXeDangBan[indexOfFilterXeDangBan].hopSo = suaHopSo
            filterXeDangBan[indexOfFilterXeDangBan].nhienLieu = suaNhienLieu
            filterXeDangBan[indexOfFilterXeDangBan].moiHayCu = suaCuMoi
            }

        chonLoaiXeTim = 3
        chonKhoangGiaTim = 3
        chonNamSanXuatTim = 3
        chonHangXeSua = 3
            
            self.dismiss(animated: true, completion: nil)
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
        suaCuMoi = ""
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
        suaNhienLieu = ""
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
        suaHopSo = ""
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
        suaHopSo = "Tự Động"
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
        suaHopSo = "Số Sàn"
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
        suaHopSo = "Bán Tự Động"
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
        suaNhienLieu = "Xăng"
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
        suaNhienLieu = "Dầu"
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
        suaNhienLieu = "Hybrid"
    }
    @IBAction func moiBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
        cuBtt.backgroundColor = .white}
        else {cuBtt.backgroundColor = grayBackground}
        moiBtt.backgroundColor = .lightGray
        suaCuMoi = "Xe mới"
    }
    
    @IBAction func cuBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
        moiBtt.backgroundColor = .white}
        else {moiBtt.backgroundColor = grayBackground}
        cuBtt.backgroundColor = .lightGray
        suaCuMoi = "Xe Cũ"
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

extension BanXeVCSuaTin: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        n
//        imageArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadAnhXeCollectionViewCell", for: indexPath) as! UploadAnhXeCollectionViewCell

        cell.anhXeImgView.image = imageArray[indexPath.row]
        cell.deleteBtt.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
//MARK: TableView

extension BanXeVCSuaTin: UITableViewDelegate, UITableViewDataSource {
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
            suaXuatXu = xuatXu[indexPath.row]
            xuatXuBtt.setTitle(" \(suaXuatXu)", for: .normal)
            chonXuatXuIsState = !chonXuatXuIsState
            tableViewXuatXu.removeFromSuperview()
        }
        else if tableView == tableViewPhienBan {
            suaPhienBan = phienBan[indexPath.row]
            chonPhienBanBtt.setTitle(" \(suaPhienBan)", for: .normal)
            chonPhienBanIsState = !chonPhienBanIsState
            tableViewPhienBan.removeFromSuperview()
        }
        
        else {
            suaMauSac = mauSac[indexPath.row]
            mauSacbtt.setTitle(" \(suaMauSac)", for: .normal)
            chonMauSacIsState = !chonMauSacIsState
            tableViewMauSac.removeFromSuperview()
        }
    }
    
}


extension BanXeVCSuaTin: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Mô tả chi tiết*"
            textView.textColor = UIColor.lightGray
    }
}

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
    }
}
}

