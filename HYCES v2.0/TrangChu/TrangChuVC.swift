//
//  TrangChuVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 07/09/2021.
//

import UIKit
import RealmSwift
import Firebase


class TrangChuVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var rightArrowLabel: UILabel!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var messageBtt: UIButton!
    @IBOutlet weak var resetBtt: UIButton!
    @IBOutlet weak var wallPaperImgView: UIImageView!
    
    @IBOutlet weak var nganDongImgView: UIImageView!
    @IBOutlet weak var collectionViewQuangCao: UICollectionView!
    @IBOutlet weak var collectionViewLocXe: UICollectionView!
    @IBOutlet weak var dangTinBtt: UIButton!
    @IBOutlet weak var homeBtt: UIButton!
    @IBOutlet weak var thongBaoBtt: UIButton!
    @IBOutlet weak var taiKhoanBtt: UIButton!
    @IBOutlet weak var listXetableView: UITableView!
    @IBOutlet weak var thongBaoMoiLabel: UILabel!
    
    var textTenHangXe: String = ""
    var hangXeTableView: UITableView!
    var loaiXeTableView: UITableView!
    var locHangXeIsState: Bool = true
    var locLoaiXeIsState: Bool = true
    // var reverse = cacThuocTinhChonXeBan.reversed()
    
    var imageArray: [UIImage] = [UIImage(named: "quangcao1")!, UIImage(named: "quangcao2")!, UIImage(named: "quangcao3")!, UIImage(named: "quangcao5")!, UIImage(named: "quangcao6")!]
    
    var timer = Timer()
    var boDem = 0
    //MARK: set màu gradient
    @IBOutlet weak var mau1Btt: UIButton!
    @IBOutlet weak var mau2Btt: UIButton!
    @IBOutlet weak var diemDauSlider: UISlider!
    @IBOutlet weak var diemCuoiSlider: UISlider!
    @IBOutlet weak var doMoSlider: UISlider!
    @IBOutlet weak var gradientView: Gradient!
    var mau1VC = UIColorPickerViewController()
    var mau2VC = UIColorPickerViewController()
    @IBOutlet weak var okBtt: UIButton!
    @IBOutlet weak var resetMauBtt: UIButton!
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var damBottomImg: UIButton!

    @IBOutlet weak var disableBackgroundView: UIView!
    @IBOutlet weak var cancelBtt: UIButton!
    @IBOutlet weak var diemDauLabel: UILabel!
    @IBOutlet weak var diemCuoiLabel: UILabel!
    @IBOutlet weak var doMoLabel: UILabel!
    @IBOutlet weak var viewChonMau: UIView!
    var x: CGFloat = 0
    
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    override func viewDidLoad() {
        print(realm.objects(ColorClass.self))
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        viewChonMau.layer.borderWidth = 1
        viewChonMau.layer.borderColor = UIColor.systemTeal.cgColor
        collectionViewQuangCao.layer.borderWidth = 1
        collectionViewQuangCao.layer.borderColor = UIColor.systemTeal.cgColor
        disableBackgroundView.isHidden = true
        viewChonMau.isHidden = true
        if chinhHinhNen == 1 { viewChonMau.isHidden = false
            disableBackgroundView.isHidden = false
            doMoSlider.value = Float(abc1!.alpha)
            doMoLabel.text = "Độ mờ: " + String(format: "%.2f", doMoSlider.value)
            diemCuoiSlider.value = Float(Double(abc1!.diemCuoi))
            diemCuoiLabel.text = "Điểm cuối: " + String(format: "%.2f", diemCuoiSlider.value)
            diemDauSlider.value = Float(Double(abc1!.diemDau))
            diemDauLabel.text = "Điểm đầu: " + String(format: "%.2f", diemDauSlider.value)
        }
        
        rightArrowLabel.isHidden = true
        homeBtt.centerXAnchor.constraint(equalTo: super.view.leadingAnchor, constant: super.view.frame.width/5 - 30).isActive = true
        dangTinBtt.centerXAnchor.constraint(equalTo: homeBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
        thongBaoBtt.centerXAnchor.constraint(equalTo: dangTinBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
        taiKhoanBtt.centerXAnchor.constraint(equalTo: thongBaoBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
        
        //        try! realm.write {
        //            abc.xe = converted}
        //        print(moiTaiKhoan)
        
        //MARK: Làm bộ đếm thời gian cho collectionView Quảng cáo
        pageView.numberOfPages = imageArray.count
        pageView.currentPage = 0
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        searchBar.layer.opacity = 0.7
        collectionViewLocXe.reloadData()
        
        
        //MARK:  lưu ý chỗ này khi chọn xong loại xe search bị reset từ đầu
        searchBar.barTintColor = .white
        searchBar.tintColor = .white
        searchBar.delegate = self
        //MARK: register tableView hiện các xe đang bán
        let nib = UINib(nibName: "DanhSachXeCuTableViewCell", bundle: nil)
        listXetableView.register(nib, forCellReuseIdentifier: "DanhSachXeCuTableViewCell")
        listXetableView.delegate = self
        listXetableView.dataSource = self
        //MARK: register collectionView
        let nib1 = UINib(nibName: "LocXeCollectionViewCell", bundle: nil)
        collectionViewLocXe.register(nib1, forCellWithReuseIdentifier: "LocXeCollectionViewCell")
        collectionViewLocXe.delegate = self
        collectionViewLocXe.dataSource = self
        collectionViewLocXe.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        let nib2 = UINib(nibName: "QuangCaoCollectionViewCell", bundle: nil)
        collectionViewQuangCao.delegate = self
        collectionViewQuangCao.dataSource = self
        collectionViewQuangCao.register(nib2, forCellWithReuseIdentifier: "QuangCaoCollectionViewCell")
        
        hangXeTableView = {
            let tb = UITableView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .white
            tb.delegate = self
            tb.dataSource = self
            tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tb
        }()
        loaiXeTableView = {
            let tb = UITableView()
            tb.translatesAutoresizingMaskIntoConstraints = false
            tb.backgroundColor = .white
            tb.delegate = self
            tb.dataSource = self
            tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            return tb
        }()
        
        
//                                try! realm.write{
//                                    realm.delete(cacThuocTinhChonXeBan[8])
//
//                                }
        
        print("""

hiện tại là2 \(currentUser1?.email!)
ko theo là. \(Auth.auth().currentUser?.email)

""")
    }
    
    @objc func changeImage() {
        if boDem < imageArray.count {
            let index = IndexPath.init(item: boDem, section: 0)
            self.collectionViewQuangCao.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = boDem
            boDem += 1
            
        } else {
            boDem = 0
            let index = IndexPath.init(item: boDem, section: 0)
            self.collectionViewQuangCao.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = boDem
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        collectionViewLocXe.reloadData()
        setThongBaoMoi(label: thongBaoMoiLabel)
        //MARK: gán màu 1, 2 lúc đầu
        if realm.objects(ColorClass.self).count == 0 {
            mau1 = .white
            mau2 = .systemIndigo
            setGradientView(View: gradientView)
//            gradientView.startColor = mau1
//            gradientView.startColor = mau2
//            gradientView.startLocation = 0
//            gradientView.endLocation = 1
//            gradientView.alpha = 0.5
        } else {
        let abcd = realm.objects(ColorClass.self)[0]
        mau1 = UIColor(red: CGFloat(abcd.colorComponents[0]), green: CGFloat(abcd.colorComponents[1]), blue: CGFloat(abcd.colorComponents[2]), alpha: CGFloat(abcd.colorComponents[3]))
        let abcd2 = realm.objects(ColorClass.self)[1]
        mau2 = UIColor(red: CGFloat(abcd2.colorComponents[0]), green: CGFloat(abcd2.colorComponents[1]), blue: CGFloat(abcd2.colorComponents[2]), alpha: CGFloat(abcd2.colorComponents[3]))
        //MARK: set gradient background
        setGradientView(View: gradientView)
        }
if let mau1btt = mau1Btt {
    mau1Btt.backgroundColor = gradientView.startColor
} else {return}
if let mau2btt = mau2Btt {
    mau2Btt.backgroundColor = gradientView.endColor
        } else {return}
        
        //MARK: Set giao diện sáng tối
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            damBottomImg.backgroundColor = .white
            resetMauBtt.backgroundColor = .white
            okBtt.backgroundColor = .systemTeal
            wallPaperImgView.isHidden = true
            wallPaperImgView.alpha = wallpaperAlpha
            gradientView.isHidden = false
            nganDongImgView.isHidden = true
            if damBottomImgState == true {
                bottomImg.isHidden = true
            } else { bottomImg.isHidden = false }
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UICollectionViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.black, for: .normal)
            searchBar.backgroundColor = .white
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.textColor = .black
            
        } else {
       
            bottomImg.isHidden = true
            gradientView.isHidden = true
            wallPaperImgView.isHidden = true
            super.view.backgroundColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UICollectionViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).layer.borderColor = UIColor.black.cgColor
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).layer.borderColor = UIColor.black.cgColor
            searchBar.backgroundColor = grayBackground
            searchBar.searchTextField.backgroundColor = grayBackground
            searchBar.searchTextField.textColor = .white
        }
        filter()
        print(realm.objects(TaiKhoan.self))
        
    }
    
    
    private func fetchData() {
        let realm = try! Realm()
        cacThuocTinhChonXeBan = realm.objects(ChonXe.self)
        let predicate = NSPredicate(format: "NOT (banHayChua CONTAINS %@)", "Đã bán")
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeBan.filter(predicate)
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.sorted(byKeyPath: "thoiGianDang", ascending: false)
        //MARK: Filter search theo điều kiện
        if chonLoaiXeTim != 2 && chonKhoangGiaTim != 2 && chonNamSanXuatTim != 2 && chonHangXeSua != 2 {listXetableView.reloadData()
            collectionViewLocXe.reloadData()}
        //MARK: mũi tên nhấp nháy
        //        self.rightArrowLabel.alpha = 1.0;
        //        UIView .animate(withDuration: 1, delay: 0.0, options: .repeat, animations: {self.rightArrowLabel.alpha = 0}, completion: nil)
        //        self.wallPaperImgView.center = CGPoint(x:view.center.x, y:view.center.y)
        //
        //        UIView .animate(withDuration: 10, delay: 0.0, options: [.repeat, .autoreverse], animations: {self.wallPaperImgView.center = CGPoint(x:self.view.center.x, y:self.view.center.y + 20)}, completion: nil)
        
        //MARK: // Thông báo notification icon
        if thongBaoMoi == 0 {
            thongBaoMoiLabel.isHidden = true}
        else {thongBaoMoiLabel.isHidden = false
            thongBaoMoiLabel.text = "\(thongBaoMoi)"
        }
        print(cacThuocTinhChonXeBan)
    }
    //MARK: đến các trang khác
    
    @IBAction func goToMessage(_ sender: Any) {
        let VC = ListMessageVC()
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        
    }
    
    @IBAction func goToDangTinVC(_ sender: Any) {
        let vc = BanXeVC()
        chonLoaiXeTim = 1
        addChonXeMoi(hangXe: "Chọn Hãng Xe", loaiXe: "Chọn Loại Xe", namSanXuat: "Chọn Năm Sản Xuất", khoangGia: "Chọn Khoảng giá", phienBan: "Chọn phiên bản", giaBan: 0, mau: "", soKmDaDi: "0", xuatXu: "", tinhTrang: "", hinhAnh1: "", hinhAnh2: "", hinhAnh3: "", hinhAnh4: "", hinhAnh5: "", hinhAnh6: "", tieuDe: "", thoiGianDang: "", diaDiem: "", taiKhoanDang: "", moiHayCu: "", anHien: "hien", banHayChua: "chua")
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goToThongBao(_ sender: Any) {
        let VC = ThongBaoVC()
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func goToTaiKhoanVC(_ sender: Any) {
        taiKhoanState = 1
        let taiKhoanVC = TaiKhoanVC()
        //taiKhoanVC.modalPresentationStyle = .overCurrentContext
        taiKhoanVC.modalTransitionStyle = .crossDissolve
        taiKhoanVC.modalPresentationStyle = .fullScreen
        self.present(taiKhoanVC, animated: true, completion: nil)
        
    }
    
    @IBAction func resetBtt(_ sender: Any) {
        UIView .animate(withDuration: 1, delay: 0.0,  animations: {
            self.resetBtt.transform = CGAffineTransform(rotationAngle: CGFloat(self.x - .pi/1.2))
            self.x -= .pi/1.2
        }, completion: nil)
        let predicate = NSPredicate(format: "NOT (banHayChua CONTAINS %@)", "Đã bán")
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeBan.filter(predicate)
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.sorted(byKeyPath: "thoiGianDang", ascending: false)
        timHangXe = "Hãng xe ▼"
        timLoaiXe = "Loại xe ▼"
        namSanXuat = "Năm sản xuất ▼"
        timKhoangGia = "Khoảng giá ▼"
        resetBttState = 2
        listXetableView.reloadData()
        collectionViewLocXe.reloadData()
    }
    

    
    func filter() {
        let predicate = NSPredicate(format: "NOT (banHayChua CONTAINS %@)", "Đã bán")
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeBan.filter(predicate)
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.sorted(byKeyPath: "thoiGianDang", ascending: false)
        if timHangXe != "Hãng xe ▼" {
            let predicate1 = NSPredicate.init(format: "hangXe contains[c] %@" , timHangXe)
            cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
        
        if timLoaiXe != "Loại xe ▼" {
            let predicate1 = NSPredicate.init(format: "loaiXe contains[c] %@" , timLoaiXe)
            cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
        
        if namSanXuat != "Năm sản xuất ▼" {
            let predicate1 = NSPredicate.init(format: "namSanXuat contains[c] %@" , namSanXuat)
            cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
        
        if timKhoangGia != "Khoảng giá ▼" {
            if timKhoangGia == "Dưới 200 triệu" {
                let predicate1 = NSPredicate.init(format: "giaBan <= %i" , 200000000)
                cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
            
            else if timKhoangGia == "200 - 500 triệu" {
                let predicate1 = NSPredicate.init(format: "giaBan > %i AND giaBan <= %i" , 200000000, 500000000)
                cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
            
            else if timKhoangGia == "500 triệu - 1 tỷ" {
                let predicate1 = NSPredicate.init(format: "giaBan >= %i AND giaBan <= %i" , 500000000, 1000000000)
                cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
            
            else if timKhoangGia == "1 - 2 tỷ" {
                let predicate1 = NSPredicate.init(format: "giaBan >= %i AND giaBan <= %i" , 1000000000, 2000000000)
                cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
            else if timKhoangGia == "> 2 tỷ" {
                let predicate1 = NSPredicate.init(format: "giaBan >= %i" , 2000000000)
                cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)}
        }
        
        listXetableView.reloadData()
        collectionViewLocXe.reloadData()
    }
    
    
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
    //MARK: Các thay đổi màu cho Gradient
    @IBAction func mau1Change(_ sender: Any) {
        mau1VC.delegate = self
        present(mau1VC, animated: true, completion: nil)
        
    }
    
    @IBAction func mau2Change(_ sender: Any) {
        
        mau2VC.delegate = self
        present(mau2VC, animated: true, completion: nil)
    }
    
    
    @IBAction func diemDauChange(_ sender: Any) {
        diemDauSlider.maximumValue = 2
        diemDauSlider.minimumValue = -2
        gradientView.startLocation = Double(diemDauSlider.value)
        diemDauLabel.text = "Điểm đầu: " + String(format: "%.2f", diemDauSlider.value)

    }
    
    @IBAction func diemCuoiChange(_ sender: Any) {
        diemCuoiSlider.maximumValue = 2
        diemCuoiSlider.minimumValue = -2
        gradientView.endLocation = Double(diemCuoiSlider.value)
        diemCuoiLabel.text = "Điểm cuối: " + String(format: "%.2f", diemCuoiSlider.value)

    }
    
    @IBAction func doMoChange(_ sender: Any) {
        doMoSlider.maximumValue = 1
        doMoSlider.minimumValue = 0
        gradientView.alpha = CGFloat(doMoSlider.value)
        doMoLabel.text = "Độ mờ: " + String(format: "%.2f", doMoSlider.value)
    }
    @IBAction func cancelBttDidTap(_ sender: Any) {
        chinhHinhNen = 0
        viewChonMau.removeFromSuperview()
        disableBackgroundView.removeFromSuperview()
        self.viewWillAppear(true)
        
    }
    
    @IBAction func resetMauBttDidTap(_ sender: Any) {
        mau1 = UIColor(red: 0.64, green: 0.63, blue: 0.87, alpha: 1.00)
        gradientView.startColor = mau1
        mau1Btt.backgroundColor = mau1
        mau2 = UIColor(red: 0.38, green: 0.38, blue: 0.62, alpha: 1.00)
        gradientView.endColor = mau2
        mau2Btt.backgroundColor = mau2
        doMoSlider.value = 1
        diemDauSlider.value = 0
        diemCuoiSlider.value = 1
        gradientView.startLocation = Double(diemDauSlider.value)
        gradientView.endLocation = Double(diemCuoiSlider.value)
        gradientView.alpha = CGFloat(doMoSlider.value)
    }
    
    @IBAction func okBttDidTap(_ sender: Any) {
        try! realm.write{
            abc1?.alpha = Float(doMoSlider.value)
        }
        try! realm.write{
            abc1?.diemCuoi = Double(diemCuoiSlider.value)
        }
        try! realm.write{
            abc1?.diemDau = Double(diemDauSlider.value)
        }
        
        let myColor = ColorClass()
        let cgOrangeComponents = mau1.cgColor.components!
        let floatOrangeComponents = cgOrangeComponents.map { Float($0) }
        
        let myColor2 = ColorClass()
        let cgOrangeComponents2 = mau2.cgColor.components!
        let floatOrangeComponents2 = cgOrangeComponents2.map { Float($0) }
        if realm.objects(ColorClass.self).count == 0 {
            myColor.colorComponents.append( floatOrangeComponents[0] )
            myColor.colorComponents.append( floatOrangeComponents[1] )
            myColor.colorComponents.append( floatOrangeComponents[2] )
            myColor.colorComponents.append( floatOrangeComponents[3] )
            myColor.taiKhoan = abc1!.id
            myColor.id = UUID().uuidString
            
            myColor2.colorComponents.append( floatOrangeComponents2[0] )
            myColor2.colorComponents.append( floatOrangeComponents2[1] )
            myColor2.colorComponents.append( floatOrangeComponents2[2] )
            myColor2.colorComponents.append( floatOrangeComponents2[3] )
            myColor2.taiKhoan = abc1!.id
            myColor2.id = UUID().uuidString
            
            try! realm.write {
                realm.add(myColor)
                realm.add(myColor2)
            }
        } else {
            try! realm.write {
                let abcd = realm.objects(ColorClass.self)[0]
                abcd.colorComponents[0] = floatOrangeComponents[0]
                abcd.colorComponents[1] = floatOrangeComponents[1]
                abcd.colorComponents[2] = floatOrangeComponents[2]
                abcd.colorComponents[3] = floatOrangeComponents[3]
                
                let abcd2 = realm.objects(ColorClass.self)[1]
                abcd2.colorComponents[0] = floatOrangeComponents2[0]
                abcd2.colorComponents[1] = floatOrangeComponents2[1]
                abcd2.colorComponents[2] = floatOrangeComponents2[2]
                abcd2.colorComponents[3] = floatOrangeComponents2[3]
            }
        }
        chinhHinhNen = 0
        disableBackgroundView.removeFromSuperview()
        viewChonMau.removeFromSuperview()
        print(realm.objects(TaiKhoan.self))
        print(realm.objects(ColorClass.self))
    }
    
    
    @IBAction func damBottomImgDidTap(_ sender: Any) {
        if damBottomImgState == true {bottomImg.isHidden = false}
        else {bottomImg.isHidden = true}
        damBottomImgState = !damBottomImgState
    }
}
//MARK: TABLEVIEW
extension TrangChuVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listXetableView {return cacThuocTinhChonXeFiltered.count} else {return hangXeList.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listXetableView {  let cell = tableView.dequeueReusableCell(withIdentifier: "DanhSachXeCuTableViewCell", for: indexPath) as! DanhSachXeCuTableViewCell
            
            let xyz = cacThuocTinhChonXeFiltered[indexPath.row]
            
            let soKmDaDiInt = (Int(xyz.soKmDaDi) ?? 0).formattedWithSeparator
            let giaBanInt = xyz.giaBan.formattedWithSeparator
            cell.anhXeImageView.image = UIImage(named: xyz.hinhAnh1)
            cell.tieuDeLabel.text = xyz.tieuDe
            cell.phienBanVaMauLabel.text = "\(xyz.loaiXe) - \(xyz.mau) - \(xyz.xuatXu)"
            cell.NamVaSoKmLabel.text = "Sx \(xyz.namSanXuat) - \(soKmDaDiInt) km"
            cell.giaLabel.text = "\(giaBanInt) đ"
            cell.giaLabel.textColor = .systemTeal
            cell.thoiGianDangLabel.text = xyz.thoiGianDang
            cell.diaDiemLabel.text = xyz.diaDiem
            return cell }
        
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = hangXeList[indexPath.row]
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
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listXetableView   {return 160} else {return 40}
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == listXetableView {
            let xyz = cacThuocTinhChonXeFiltered[indexPath.row]
            primaryKey = xyz.id
            let chiTietXeCuVC = ChiTietXeCuVC()
            
            dangTinState = 2
            chiTietXeCuVC.modalPresentationStyle = .fullScreen
            self.present(chiTietXeCuVC, animated: true, completion: nil)
        }
        else {
            let indexPath = tableView.indexPathForSelectedRow
            let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
            timHangXe = (currentCell.textLabel?.text)!
            locLabelTren = [timHangXe, timLoaiXe, namSanXuat , timKhoangGia, "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
            chonHangXeSua = 2
            hangXeTableView.removeFromSuperview()
            locHangXeIsState = !locHangXeIsState
            filter()
            listXetableView.reloadData()
            collectionViewLocXe.reloadData()
            
        }
    }
}

//MARK: COLLECTIONVIEW
extension TrangChuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  collectionViewLocXe  {return locLabelTren.count} else {
            return imageArray.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView ==  collectionViewLocXe {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocXeCollectionViewCell", for: indexPath) as! LocXeCollectionViewCell
            
            if resetBttState == 2 {
                timHangXe = "Hãng xe ▼"
                timLoaiXe = "Loại xe ▼"
                namSanXuat = "Năm sản xuất ▼"
                locLabelTren = [timHangXe, timLoaiXe, namSanXuat, "Khoảng giá ▼", "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
                resetBttState = 1
            }
            cell.layer.borderColor = UIColor.systemTeal.cgColor
            cell.layer.borderWidth = 1
            cell.layer.masksToBounds = true
            cell.labelTren.text = locLabelTren[indexPath.row]
            cell.label.text = locLabel[indexPath.row]
            //   cell.backgroundColor = listMau[indexPath.row]
            cell.layoutIfNeeded()
            return cell }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuangCaoCollectionViewCell", for: indexPath) as! QuangCaoCollectionViewCell
            cell.image.image = imageArray[indexPath.row]
            
            return cell }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        _ = collectionView.cellForItem(at: indexPath) as?
            LocXeCollectionViewCell
        //MARK: MỞ CÁC TABLEVIEW KHÁC NHAU
        
        if indexPath == [0, 0]
        { cacThuocTinhChonXeFiltered = cacThuocTinhChonXeBan
            searchBar.text = ""
            if locHangXeIsState == true {
                super.view.addSubview(hangXeTableView)
                hangXeTableView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 90).isActive = true
                hangXeTableView.leadingAnchor.constraint(equalTo: super.view.leadingAnchor).isActive = true
                hangXeTableView.trailingAnchor.constraint(equalTo: super.view.trailingAnchor).isActive = true
                hangXeTableView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: -90).isActive = true
                
            }
            else {
                hangXeTableView.removeFromSuperview()
            }
            locHangXeIsState = !locHangXeIsState
            collectionView.reloadData()
        }
        else if indexPath == [0, 1] {
            searchBar.text = ""
            if timHangXe == "Hãng xe ▼" {
                showAlertAction(title: "Lưu ý", message: "Chưa chọn hãng xe")
            }
            else { let VC = ChonLoaiXeBan()
                VC.modalTransitionStyle = .crossDissolve
                VC.modalPresentationStyle = .fullScreen
                chonLoaiXeTim = 2
                
                self.present(VC, animated: true, completion: nil)}
            
        }
        else if indexPath == [0, 2] {
            searchBar.text = ""
            let VC = ChonNamSanXuatBan()
            VC.modalTransitionStyle = .crossDissolve
            VC.modalPresentationStyle = .fullScreen
            chonNamSanXuatTim = 2
            self.present(VC, animated: true, completion: nil)
        }
        
        else if indexPath == [0, 3] {
            searchBar.text = ""
            let VC = ChonKhoangGia()
            VC.modalTransitionStyle = .crossDissolve
            VC.modalPresentationStyle = .fullScreen
            chonKhoangGiaTim = 2
            self.present(VC, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
//MARK: search bar
extension TrangChuVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let predicate = NSPredicate(format: "NOT (banHayChua CONTAINS %@)", "Đã bán")
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeBan.filter(predicate)
        cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.sorted(byKeyPath: "thoiGianDang", ascending: false)
        searchBar.layer.opacity = 1
        
        if searchText != "" {
            let predicate1 = NSPredicate(format: "hangXe contains[cd] %@ OR loaiXe contains[cd] %@ OR namSanXuat contains[cd] %@ OR giaBan == %i OR mau contains[cd] %@ OR soKmDaDi contains[cd] %@ OR xuatXu contains[cd] %@ OR tinhTrang contains[cd] %@ OR diaDiem contains[cd] %@ OR tieuDe contains[cd] %@ OR hopSo contains[cd] %@ OR nhienLieu contains[cd] %@" , searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText)
            cacThuocTinhChonXeFiltered = cacThuocTinhChonXeFiltered.filter(predicate1)
        }
        
        listXetableView.reloadData()
        
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchBar.layer.opacity = 0.7}
    }
}
//MARK: ColorPiker Viewcontroller
extension TrangChuVC: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {

        if viewController == mau1VC {
            mau1 = viewController.selectedColor
            print("màu 1 : \(mau1)")
                gradientView.startColor = mau1
            mau1Btt.backgroundColor = gradientView.startColor
            
            }
        else {
            mau2 = viewController.selectedColor
            print("màu 1 : \(mau2)")
                gradientView.endColor = mau2
            mau2Btt.backgroundColor = gradientView.endColor
            }
        
}
}


//MARK: convert realm result thành list <>

//       guard let user = Auth.auth().currentUser else {return}
//        let predicate = NSPredicate(format: "taiKhoan contains %@", user.uid as CVarArg)
//        let chonXeList = cacThuocTinhChonXeBan.filter(predicate)
//        let abc = moiTaiKhoan[moiTaiKhoan.count - 1]
//
//        let converted = chonXeList.reduce(List<ChonXe>()) { (list, element) -> List<ChonXe> in
//            list.append(element)
//            return list
//        }

//    func generateAttributedString(with searchTerm: String, targetString: String) -> NSAttributedString? {
//
//        let attributedString = NSMutableAttributedString(string: targetString)
//        do {
//            let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
//            let range = NSRange(location: 0, length: targetString.utf16.count)
//            for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
//                attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold), range: match.range)
//            }
//            return attributedString
//        } catch {
//            NSLog("Error creating regular expresion: \(error)")
//            return nil
//        }
//    }

