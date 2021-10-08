//
//  FunctionClass.swift
//  HYCES v2.0
//
//  Created by Duong Le on 10/09/2021.
//

import Foundation
import RealmSwift
import UIKit
import Firebase
//MARK: Set FireBase Storage
let storage = Storage.storage()
let storageRef = storage.reference()

//MARK: set giao diện
var moLaiSuaTaiKhoanVC = 0
var nganDongView: UIView!
let wallpaperName = "blueglow"
let wallpaperAlpha: CGFloat = 0.2
var mau1: UIColor = .white
var mau2: UIColor = .systemIndigo
var chinhHinhNen = 0
var damBottomImgState: Bool = false
let grayBackground: UIColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
//MARK: Set Realm Tài khoản

var currentUser1 = Auth.auth().currentUser
var abc1 = realm.object(ofType: TaiKhoan.self, forPrimaryKey: currentUser1?.uid)

//MARK: set realm
let realm = try! Realm()
//let predicateTaiKhoanObject = NSPredicate(format: "taiKhoan contains[cd] %@", currentUser1?.uid as! CVarArg)
//var colorRealm = realm.objects(ColorClass.self).filter(predicateTaiKhoanObject)
var cacThuocTinhChonXeBan = realm.objects(ChonXe.self)
var cacThuocTinhChonXeFiltered = realm.objects(ChonXe.self)
var filterXeDangBan = realm.objects(ChonXe.self)
var indexOfFilterXeDangBan: Int = 0
var filterXeDaBan = realm.objects(ChonXe.self)
var moiTaiKhoan = realm.objects(TaiKhoan.self)
var taiKhoanState: Int = 1
var dangTinState: Int = 1 // 1 vào từ trang bán xe, 2 vào từ trang chủ
var resetBttState: Int = 1
var chonLoaiXeTim: Int = 1 // 1 là giá trị khi lấy ở trang Bán Xe, 2 là giá trị lấy ở trang Chủ khi lọc, 3 là giá trị khi sửa tin
var chonNamSanXuatTim: Int = 1
var chonKhoangGiaTim: Int = 1

var chonHangXeSua: Int = 1 // 1 giá trị khi lấy ở trang bán xe, 2 là giá trị lấy ở trang chủ khi lọc, 3 giá trị khi lấy ở trang sửa xe
var suaHangXe: String = ""
var suaPhienBan: String = ""
var suaLoaiXe: String = ""
var suaNamSanXuat: String = ""
var suaMauSac: String = ""
var suaXuatXu: String = ""
var suaHopSo: String = ""
var suaNhienLieu: String = ""
var suaCuMoi: String = ""
var cacThuocTinhChonXeFilteredState: Int = 1

var timHangXe: String = "Hãng xe ▼"
var timLoaiXe: String = "Loại xe ▼"
var namSanXuat: String = "Năm sản xuất ▼"
var timKhoangGia: String = "Khoảng giá ▼"

var listMau: [UIColor] = [ #colorLiteral(red: 0.9802958369, green: 0.9804596305, blue: 0.98027426, alpha: 1), #colorLiteral(red: 0.9018717408, green: 0.9020231366, blue: 0.9018518329, alpha: 1), #colorLiteral(red: 0.8234478831, green: 0.823586762, blue: 0.8234294653, alpha: 1), #colorLiteral(red: 0.7450567484, green: 0.7450756431, blue: 0.749317944, alpha: 1), #colorLiteral(red: 0.6665995121, green: 0.666713655, blue: 0.6665844917, alpha: 1), #colorLiteral(red: 0.5882086158, green: 0.5882026553, blue: 0.5924727321, alpha: 1), #colorLiteral(red: 0.5441390872, green: 0.5492941737, blue: 0.5447138548, alpha: 1), #colorLiteral(red: 0.5049597621, green: 0.5100019574, blue: 0.5098162889, alpha: 1)]

//var listMau: [UIColor] = [.white, .systemGray6, .systemGray5, .systemGray4, .systemGray3, .systemGray2, .lightGray, .systemGray]
var locLabelTren: [String] = [timHangXe, timLoaiXe, namSanXuat, timKhoangGia, "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
var locLabel: [String] = ["Chọn hãng xe", "Chọn loại xe", "Chọn năm SX", "Chọn khoảng giá", "Chọn phiên bản", "Chọn màu", "Chọn xuất xứ", "Chọn tình trạng"]

var primaryKey: String = ""
var primaryKeySuaTin: String = ""

let hangXeList: [String] =  ["Acura", "Audi", "Bentley", "BMW", "Cadillac", "Chevrolet", "Ferrari", "Ford", "Honda", "Huyndai", "Infiniti", "Isuzu", "Kia", "LandRover", "Lexus", "MayBach", "Mazda", "Mecedes","Mitsubishi", "Nissan", "Peugeot", "Posrche", "Renault", "Rolls Royce", "Suzuki", "Toyota", "Vinfast", "Volkswagen", "Volvo", "Loại khác" ]


let loaiXeHuyndai: [String] = ["Grand I10", "Elantra", "Santafe", "Tucson", "Kona", "Genesis", "Accent", "Loại khác"]
let loaiXeFord: [String] = ["EcoSport", "Focus", "Everest", "Range", "Explorer", "Raptor", "Fiesta", "Tourneo", "Loại khác"]
let loaiXeMec: [String] = ["C 180", "C 200", "C 300", "E 180", "E 300", "S 450", "Maybach", "GLC 200", "GLC 300", "AMG A 35 ", "Loại khác"]
let loaiXeAudi: [String] = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "Q2", "Q3", "Q5", "Q7", "R8", "Loại khác"]
let loaiXeBMW: [String] = ["1 Series", "2 Series", "3 Series", "4 Series", "5 Series", "6 Series", "7 Series", "8 Series", "X1", "X3", "X5", "X7", "M2", "M3",  "Loại khác"]
let loaiXeChevrolet: [String] = ["Aveo", "Camaro", "Captiva", "Cavalier", "Chevyvan", "Collorado", "Corsica", "Cruze", "Express", "Kalos", "Silverado", "Trailblazer", "Vivant",  "Loại khác"]
let loaiXeHonda: [String] = ["Accord", "Brio", "City", "Civic", "CR-V", "CR-X", "Domani", "Element", "HR-V", "Integra", "Jazz", "Odyssey", "Loại khác"]
let loaiXeIsuzu: [String] = ["Dmax", "Hi lander", "Midi", "Rodeo", "Trooper","Loại khác"]
let loaiXeKia: [String] = ["Carens", "Carnival", "Cerato", "Concord", "Forte", "Jeep", "K3", "K5", "K7", "Morning", "Optima", "Picanto", "Pride", "Sedona","Seltos", "Sorento", "Soul", "Sportage",  "Loại khác"]
let loaiLexus: [String] = ["ES", "GS", "GX", "IS", "LS", "LX", "NX", "RC", "RX", "SL", "Loại khác"]
let loaiMazda: [String] = ["BT 50", "2", "3", "5", "6", "CX 3", "CX 5", " CX 7", "CX 8", "CX 9", "MPV", "Premacy", "RX7", "RX8", "Xedos 9", "Loại khác"]
let loaiMitsubishi: [String] = ["Attrage", "Colt", "Wagon", "Grandis", "Hover", "Jolie", "L200", "L300", "Libero", "Mirage", "Outlander", "Pajero Sport", "Triton", "Xpande", "Loại khác"]
let loaiNissan: [String] = ["200SX", "240SX", "Almera", "Cedric", "Frontier", "Pathfinder", "PaTrol", "President", "Primasta", "Qashqai", "Rogue", "Sentra", "Sunny", "X Trail", "Loại khác"]
let loaiToyota: [String] = ["4 Runner", "Alphard", "Avanza", "Avensis", "Camry", "Century", "Corolla", "Cresta", "Estima", "Fortuner", "Innova", "LandCruiser", "Prado", "Prius", "Rav4", "Rush", "Sequoia", "Sera", "Sienna", "Venza", "Vios", "Vista", "Wigo", "Yaris", "Loại khác"]
let loaiVinfast: [String] = ["Fadil", "Lux", "President", "VFe34", "Loại khác"]

let loaiXeKhac: [String] = ["Chưa có dữ liệu"]

let phienBan: [String] = ["Full option", "Base", "4x2", "4x4", "Deluxe", "Luxury", "Premium"]

let diaDiem: [String] = ["Hà Nội", "Hà Nam", "Thái Bình", "TP.HCM", "Hải Phòng", "Đà Nẵng", "Lào Cai", "Bắc Giang", "Nam Định", "Cần Thơ", "Bắc Ninh", "Thái Nguyên", "Yên Bái"]

let cacNamSanXuat: [String] = ["2021","2020","2019","2018","2017","2016","2015","2014","2013","2012","2011", "2010" ,"2009" ,"2008" ,"2007" ,"2006" ,"2005" ,"2004" ,"2003" ,"2002" ,"2001" ,"2000" , "Trước 2000" ]

let xuatXu: [String] = ["Không chọn", "Việt Nam", "Ấn Độ", "Hàn Quốc", "Thái Lan", "Indonesia", "Nhật Bản", "Trung Quốc", "Mỹ", "Châu Âu", "Nước khác"]

let kieuDang: [String] = ["Sedan", "SUV", "Hatchback", "Pick-up", "Minivan (MPV)", "Van", "Coupe (2 cửa)", "Mui trần", "Kiểu khác"]

let mauSac: [String] = ["Không chọn", "Trắng", "Đen", "Ghi", "Bạc", "Đỏ", "Vàng", "Cam", "Xanh dương", "Hồng", "Nâu", "Màu khác"]
var cacKhoangGia: [String] = ["Dưới 200 triệu","200 - 500 triệu","500 triệu - 1 tỷ","1 - 2 tỷ", "> 2 tỷ" ]

let soCho: [String] = ["2", "4", "5", "6", "7", "8", "9", "10", "12", "14", "16", "Khác"]

func addChonXeMoi(hangXe: String, loaiXe: String, namSanXuat: String, khoangGia: String, phienBan:String, giaBan: Int,  mau: String, soKmDaDi: String, xuatXu:String, tinhTrang: String, hinhAnh1: String, hinhAnh2: String,hinhAnh3: String,hinhAnh4: String, hinhAnh5: String, hinhAnh6: String, tieuDe: String, thoiGianDang: String, diaDiem: String, taiKhoanDang: String, moiHayCu: String, anHien: String, banHayChua: String) {
    let doiTuongChonXeMoi = ChonXe()

    doiTuongChonXeMoi.hangXe = hangXe
    doiTuongChonXeMoi.loaiXe = loaiXe
    doiTuongChonXeMoi.namSanXuat = namSanXuat
    doiTuongChonXeMoi.khoangGia = khoangGia
    doiTuongChonXeMoi.phienBan = phienBan
    doiTuongChonXeMoi.giaBan = giaBan
    doiTuongChonXeMoi.mau  = mau
    doiTuongChonXeMoi.soKmDaDi = soKmDaDi
    doiTuongChonXeMoi.xuatXu = xuatXu
    doiTuongChonXeMoi.tinhTrang = tinhTrang
    doiTuongChonXeMoi.hinhAnh1 = hinhAnh1
    doiTuongChonXeMoi.hinhAnh2 = hinhAnh2
    doiTuongChonXeMoi.hinhAnh3 = hinhAnh3
    doiTuongChonXeMoi.hinhAnh4 = hinhAnh4
    doiTuongChonXeMoi.hinhAnh5 = hinhAnh5
    doiTuongChonXeMoi.hinhAnh6 = hinhAnh6
    doiTuongChonXeMoi.tieuDe   = tieuDe
    doiTuongChonXeMoi.thoiGianDang = thoiGianDang
    doiTuongChonXeMoi.diaDiem = diaDiem
    doiTuongChonXeMoi.taiKhoanDang = taiKhoanDang
    doiTuongChonXeMoi.moiHayCu = moiHayCu
    doiTuongChonXeMoi.anHien = anHien
    doiTuongChonXeMoi.banHayChua = banHayChua
    doiTuongChonXeMoi.id = UUID().uuidString
  let realm = try! Realm()
  try! realm.write {
      realm.add(doiTuongChonXeMoi)
  }
}


//MARK: func tạo list tên ảnh ngẫu nhiên để lưu vào RealmSwift
func getListOfImageName() -> [String] {
    var imageNameList: [String]!
    let int = Int.random(in: 1...22)
    imageNameList = ["\(int).1", "\(int).2",  "\(int).3", "\(int).4", "\(int).5", "\(int).6"]
    return imageNameList
    }

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}


//MARK: hàm lấy ngày giờ hiện tại
func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yy  HH:mm" //If you dont want static "UTC" you can go for ZZZZ instead of 'UTC'Z.
    formatter.timeZone = TimeZone(abbreviation: "GMT+7")
    let result1 = formatter.string(from: date)
return result1
}

func formatSo (so: Double) -> String {
    var soDaFormat: String
 if so >= 1000000000 {
   
    
    soDaFormat = "\((so/1000000).rounded()/1000) tỷ "
    return soDaFormat
 }
    else if so <= 1000000000 && so >= 1000000 {
    soDaFormat = "\((so/1000000).rounded()) triệu "
        return soDaFormat
    }
    
    else {return String(so.rounded())}
}
  
extension UIAlertController {

  //Set background color of UIAlertController
  func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
  func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
        range: NSMakeRange(0, title.map { String($0)}.count))
    }
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
        range: NSMakeRange(0, title.map { String($0)}.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }

  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let title = self.message else {
      return
    }
    let attributedString = NSMutableAttributedString(string: title)
    if let titleFont = font {
        attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.map { String($0)}.count ))
    }
    if let titleColor = color {
      attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.map { String($0)}.count ))
    }
    self.setValue(attributedString, forKey: "attributedMessage")//4
  }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}
//MARK: dữ liệu cho Thông báo VC
var noiDungArray =
["Chúc mừng bạn! Đã đăng bán thành công sản phẩm đầu tiên",
"Minh Khánh đã gửi 1 tin nhắn cho bạn, hãy kiểm tra ngay",
"Vũ Mạnh Đức quan tâm đến sản phẩm bạn đăng bán, hãy liên lạc ngay",
"Thu Lê đã để lại đánh giá cho bạn, phản hồi để xây dựng cộng đồng lớn mạnh hơn",
"Bạn đã giành được 4 sao kinh nghiệm"]
var thoiGianArray = ["5:45", "19:20", "23-4", "26-4", "1-3"]
var imageArrayTb: [UIImage] = [UIImage(named: "car wall")!, UIImage(named: "avatar2")!, UIImage(named: "2.3")!, UIImage(named: "3.1")!, UIImage(named: "4.2")!,]
var thongBaoMoi: Int = 0
var idArray = ["0", "1", "2", "3", "4"]

//MARK: design Gradient Background
@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
//MARK: SET GRADIENT VIEW
func setGradientView(View:Gradient) {
    if realm.objects(ColorClass.self).count == 0 {
        View.startColor = mau1
        View.endColor = mau2
        View.startLocation = -1
        View.endLocation = 2
        View.alpha = 0
    }

    else if realm.objects(ColorClass.self).count == 2 {
        
        let abcd = realm.objects(ColorClass.self)[0]
        View.startColor = UIColor(red: CGFloat(abcd.colorComponents[0]), green: CGFloat(abcd.colorComponents[1]), blue: CGFloat(abcd.colorComponents[2]), alpha: CGFloat(abcd.colorComponents[3]))
        let abcd1 = realm.objects(ColorClass.self)[1]
        View.endColor = UIColor(red: CGFloat(abcd1.colorComponents[0]), green: CGFloat(abcd1.colorComponents[1]), blue: CGFloat(abcd1.colorComponents[2]), alpha: CGFloat(abcd1.colorComponents[3]))
    }
    View.startLocation = abc1!.diemDau
    View.endLocation = abc1!.diemCuoi
    View.alpha = CGFloat(abc1!.alpha)
}

func setThongBaoMoi(label: UILabel)  {
    if thongBaoMoi == 0 {
        label.isHidden = true}
    else {label.isHidden = false
        label.textColor = .white
        label.backgroundColor = .red
        label.text = "\(thongBaoMoi)"
    }
}

func setUiviewBorder(uiview: UIView)  {
    uiview.layer.borderWidth = 1
    uiview.layer.borderColor = UIColor.systemTeal.cgColor
}

extension UIViewController {
    //MARK: extension dismiss bàn phím ảo khi chạy trên iphone thật
    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: đẩy layout lên trên khi nhập chữ
    func pushKeyboardUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -220 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}
//MARK:  thiết kế button
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

//MARK:  thiết kế label
@IBDesignable extension UILabel {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UIImageView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UITableView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UITextField {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable class BorderView : UIView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UICollectionView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@IBDesignable extension UITextView {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}



//func addDanhGia(diemDanhGia: Double, tongDanhGia: Double) {
//    var db: Firestore!
//    db = Firestore.firestore()
//    let user = Auth.auth().currentUser
//    guard let userEmail = user?.email else {return}
//    db.collection("danhGia").document("\(userEmail)").setData([
//        "diemDanhGia": diemDanhGia,
//        "TongDanhGia": tongDanhGia,
//    ], merge: true)
//}
//
//
//private func getDiemDanhGia()  {
//    var db: Firestore!
//    db = Firestore.firestore()
//    let user = Auth.auth().currentUser
//    guard let userEmail = user?.email else {return}
//    let docRef = db.collection("danhGia").document("\(userEmail)")
//
//    docRef.getDocument { (document, error) in
//        if let document = document, document.exists {
//         if let dataDescription = document.data().map{$0["diemDanhGia"]!}
//           {print("Document data: \(dataDescription)")} else {return}
//        } else {
//            print("Document does not exist")
//        }
//    }
//}
