//
//  TaiKhoanVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 07/09/2021.
//

import UIKit
import Foundation
import RealmSwift
import Firebase


class TaiKhoanVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var xeDangBanTableView: UITableView!
    @IBOutlet weak var xeDaBanTableView: UITableView!
    @IBOutlet weak var toTrangChubtt: UIButton!
    @IBOutlet weak var dangXuatBtt: UIButton!
    @IBOutlet weak var thongBaoMoiLabel: UILabel!
    
    @IBOutlet weak var taiKhoanBtt: UIButton!
    
    @IBOutlet weak var dangTinBtt: UIButton!
    @IBOutlet weak var toSuaTrangCaNhan: UIButton!
    
    @IBOutlet weak var thongBaoBtt: UIButton!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var bottomImg: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var chiTietView: UIView!
    
    @IBOutlet weak var gradientView: Gradient!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var disableBackgroundView: UIView!
    //MARK: Phần đánh giá
    @IBOutlet weak var popUpDanhGia: CosmosView!
    @IBOutlet weak var danhGiaBtt: UIButton!
    @IBOutlet weak var danhGiaView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var okBtt: UIButton!
    @IBOutlet weak var cancelBtt: UIButton!
	var rating: Double = 0
	var db: Firestore!
    @IBOutlet weak var diemDanhGiaLabel: UILabel!
    @IBOutlet weak var tongDanhGiaLabel: UILabel!
    
    
    var userID: String = ""
	//MARK: set statusbar dark or light
	override var preferredStatusBarStyle: UIStatusBarStyle {
			if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
		   }
    override func viewDidLoad() {
        super.viewDidLoad()
		db = Firestore.firestore()
        danhGiaBtt.setTitleColor(.systemTeal, for: .normal)
        disableBackgroundView.isHidden = true
        danhGiaView.isHidden = true

        ratingView.settings.fillMode = .precise
		
        setUiviewBorder(uiview: avatarView)
		setUiviewBorder(uiview: chiTietView)
		
	
		
		toTrangChubtt.centerXAnchor.constraint(equalTo: super.view.leadingAnchor, constant: super.view.frame.width/5 - 30).isActive = true
		dangTinBtt.centerXAnchor.constraint(equalTo: toTrangChubtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
		thongBaoBtt.centerXAnchor.constraint(equalTo: dangTinBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
		taiKhoanBtt.centerXAnchor.constraint(equalTo: thongBaoBtt.centerXAnchor, constant: super.view.frame.width/5 + 20).isActive = true
		
        if thongBaoMoi == 0 {
            thongBaoMoiLabel.isHidden = true}
        else {thongBaoMoiLabel.isHidden = false
			thongBaoMoiLabel.text = "\(thongBaoMoi)"
		}

		xeDangBanTableView.reloadData()
		xeDaBanTableView.reloadData()

	//	let userId = user?.uid

        xeDangBanTableView.delegate = self
        xeDangBanTableView.dataSource = self
		let nib = UINib(nibName: "XeDangBanTableViewCell", bundle: nil)
        xeDangBanTableView.register(nib, forCellReuseIdentifier: "XeDangBanTableViewCell")
		xeDangBanTableView.rowHeight = 100
		
        xeDaBanTableView.delegate = self
        xeDaBanTableView.dataSource = self
        xeDaBanTableView.register(DaBanTableViewCell.self, forCellReuseIdentifier: "cell")
        xeDaBanTableView.rowHeight = 75
		let predicateDangBan = NSPredicate(format: "taiKhoan contains[c] %@", userID)
		// @"NOT (listingID CONTAINS %@)", sessionID
		filterXeDangBan = cacThuocTinhChonXeBan.filter(predicateDangBan)
		
		let predicateDaBan = NSPredicate(format: "banHayChua CONTAINS %@", "Đã bán")
		filterXeDaBan = filterXeDangBan.filter(predicateDaBan)
		
		let predicateDangBan1 = NSPredicate(format: "NOT (banHayChua CONTAINS %@)", "Đã bán")
		filterXeDangBan = filterXeDangBan.filter(predicateDangBan1)
		

    }
	override func viewWillAppear(_ animated: Bool) {
		//MARK: setup rating
		
		if taiKhoanState == 2 { // vào từ phần chi tiết xe, xem thông tin user khác
			toSuaTrangCaNhan.isHidden = true
			danhGiaBtt.isHidden = false
			let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
			let xyz = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc?.taiKhoan)
			userID = abc!.taiKhoan
			userNameLabel.text = xyz?.name
			var ref = storageRef.child("Avatar/\(xyz?.email ?? "")")
			ref.downloadURL(completion: { (url, error) in
								if (error == nil) {
									self.avatarImage.sd_setImage(with: url, completed: nil)
									}
								 else {
								}
			}
			)
			let abc3 = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
			let user3 = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc3?.taiKhoan)
			guard let userEmail = user3?.email else {return}
			let docRef = db.collection("danhGia").document("\(userEmail)")
			docRef.getDocument(source: .server) { (document, error) in
				if let document = document {
					
					guard let getTongDanhGia = document.get("tongDanhGia") as? Double else {self.addDanhGia(diemDanhGia: 0, tongDanhGia: 0)
						self.ratingView.rating = 0
						self.ratingLabel.text = "Đánh giá: 0/5"
						return
					}
					let getDiemDanhGia = document.get("diemDanhGia") as! Double
					self.diemDanhGiaLabel.text = "Đánh giá:  " + String(format: "%.1f", getDiemDanhGia) + "/5 "
					self.tongDanhGiaLabel.text = "\(Int(getTongDanhGia)) đánh giá"
					self.ratingView.rating = getDiemDanhGia
					
				} else {
					self.addDanhGia(diemDanhGia: 0, tongDanhGia: 0)
					self.ratingView.rating = 0
					self.ratingLabel.text = "Đánh giá: 0/5"
					
				}
			
			}
		}
		else { // vào từ tabbar xem tài khoản của mình
			danhGiaBtt.isHidden = true
			let abc = Auth.auth().currentUser
			userID = abc!.uid
			userNameLabel.text = abc?.displayName
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
		}


		

		//--------------------
		setThongBaoMoi(label: thongBaoMoiLabel)
		if moLaiSuaTaiKhoanVC == 1 {
		let vc = SuaTaiKhoanVC()
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .crossDissolve
			self.present(vc, animated: false, completion: nil)
			moLaiSuaTaiKhoanVC = 0
		}
        setGradientView(View: gradientView)
		if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
			wallPaperImgView.alpha = wallpaperAlpha
            wallPaperImgView.isHidden = true
			if damBottomImgState == true {
				bottomImg.isHidden = true
			} else { bottomImg.isHidden = false }
			super.view.backgroundColor = .white
            topView.backgroundColor = .clear
            avatarView.backgroundColor = .white
            chiTietView.backgroundColor = .white
			xeDaBanTableView.backgroundColor = .white
	UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
			UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
			UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
			UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.black, for: .normal)
			UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
			UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
			toSuaTrangCaNhan.setTitleColor(.systemTeal, for: .normal)
			dangXuatBtt.backgroundColor = .white
		}
		else { bottomImg.isHidden = true
            wallPaperImgView.isHidden = true
			wallPaperImgView.image = UIImage(named: "wallpaper3")
			wallPaperImgView.alpha = 1
            gradientView.isHidden = true
			danhGiaView.backgroundColor = grayBackground
			super.view.backgroundColor = .black
            topView.backgroundColor = .clear
            avatarView.backgroundColor = grayBackground
            chiTietView.backgroundColor = grayBackground
			xeDaBanTableView.backgroundColor = grayBackground
			UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
			UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
			UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
			UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).setTitleColor(.white, for: .normal)
			UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
			UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
			toSuaTrangCaNhan.setTitleColor(.systemTeal, for: .normal)
			dangXuatBtt.backgroundColor = grayBackground		}
		xeDangBanTableView.reloadData()
		xeDaBanTableView.reloadData()
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if tableView == xeDangBanTableView {return 100} else {return 75}
	}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == xeDangBanTableView {return filterXeDangBan.count} else {return filterXeDaBan.count}
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == xeDangBanTableView {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "XeDangBanTableViewCell", for: indexPath) as! XeDangBanTableViewCell

            if abc1?.theme == 1 {
                cell.backgroundColor = grayBackground
            } else {cell.backgroundColor = . white}
            
			cell.suaBtt.addTarget(self, action: #selector(suaTinDang), for: .touchUpInside)
			cell.xoaBtt.addTarget(self, action: #selector(xoaTinDang), for: .touchUpInside)
			cell.daBanBtt.addTarget(self, action: #selector(daBan), for: .touchUpInside)
        cell.anhXeImage.image = UIImage(named: filterXeDangBan[indexPath.row].hinhAnh1)
        cell.anhXeImage.contentMode = .scaleAspectFill
		cell.thuocTinhLabel.text = "Năm \(filterXeDangBan[indexPath.row].namSanXuat) - \(filterXeDangBan[indexPath.row].soKmDaDi) km - \(filterXeDangBan[indexPath.row].mau)"
		cell.giaLabel.text = "Giá: \(filterXeDangBan[indexPath.row].giaBan.formattedWithSeparator) đ"
        cell.tieuDeLabel.text = filterXeDangBan[indexPath.row].tieuDe
        cell.tieuDeLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
			cell.giaLabel.textColor = .systemTeal
            
        
            return cell }
        
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DaBanTableViewCell
			if abc1?.theme == 1 {
				cell.backgroundColor = grayBackground
			} else {cell.backgroundColor = . white}
            cell.giaLabel.text = "Giá: \(filterXeDaBan[indexPath.row].giaBan.formattedWithSeparator) đ"
			cell.ngayBanLabel.text = "Ngày bán: \(filterXeDaBan[indexPath.row].thoiGianDang)"
            cell.tieuDeLabel.text = filterXeDaBan[indexPath.row].tieuDe
            cell.tieuDeLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
            cell.tieuDeLabel.numberOfLines = 1
			cell.giaLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.giaLabel.textColor = .systemTeal
            
                return cell }
    }
//MARK: Xử lý phần đánh giá
    
    @IBAction func danhGia(_ sender: Any) {
		disableBackgroundView.isHidden = false
        danhGiaView.isHidden = false
		okBtt.backgroundColor = .systemTeal
        popUpDanhGia.settings.fillMode = .half
		popUpDanhGia.rating = 0
        ratingLabel.text = "0/5"
    }

    @IBAction func okBttDidTap(_ sender: Any) {
		if popUpDanhGia.rating < 1 {
		showAlertAction(title: "Lưu ý", message: "Đánh giá thấp nhất là 1 sao")
		} else {
			let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
			let user = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc?.taiKhoan)
			guard let userEmail = user?.email else {return}
			let docRef = db.collection("danhGia").document("\(userEmail)")
			docRef.getDocument(source: .server) { (document, error) in
				if let document = document {
					
					let getTongDanhGia = document.get("tongDanhGia") as! Double + 1
					let getDiemDanhGia = (document.get("diemDanhGia") as! Double * (getTongDanhGia - 1) + self.rating)/getTongDanhGia
					self.addDanhGia(diemDanhGia: getDiemDanhGia, tongDanhGia: getTongDanhGia)
				} else {
					let TongDanhGia = 1
					let DiemDanhGia = self.rating
					self.addDanhGia(diemDanhGia: DiemDanhGia, tongDanhGia: Double(TongDanhGia))
				}
			}
			
		}
        danhGiaView.isHidden = true
		disableBackgroundView.isHidden = true
    }
    
    @IBAction func tapStarRating(_ sender: Any) {
        ratingLabel.text = String(format: "%.1f", popUpDanhGia.rating) + "/5"
		rating = popUpDanhGia.rating
    }
    
    @IBAction func cancelDanhGiaDidTap(_ sender: Any) {
        danhGiaView.isHidden = true
        disableBackgroundView.isHidden = true
    }
    
	func addDanhGia(diemDanhGia: Double, tongDanhGia: Double) {
		let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
		let user = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc?.taiKhoan)
		guard let userEmail = user?.email else {return}
		db.collection("danhGia").document("\(userEmail)").setData([
			"diemDanhGia": diemDanhGia,
			"tongDanhGia": tongDanhGia,
		], merge: true)
	}
	

	
	//MARK: 3 hàm add vào button sửa, xoá, đã bán
	@objc func suaTinDang(_ sender: UIButton) {
		let point = sender.convert(CGPoint.zero, to: xeDangBanTableView)
		guard let indexPath1 = xeDangBanTableView.indexPathForRow(at: point)
		else {return}
		indexOfFilterXeDangBan = indexPath1.row
		chonLoaiXeTim = 3
		chonKhoangGiaTim = 3
		chonNamSanXuatTim = 3
		chonHangXeSua = 3
		let VC = BanXeVCSuaTin()
		VC.modalPresentationStyle = .fullScreen
		VC.modalTransitionStyle = .crossDissolve
		self.present(VC, animated: true, completion: nil)
	}
	
	@objc func xoaTinDang(_ sender: UIButton) {
	
			let alert = UIAlertController(title: "Xác nhận", message: "Bạn muốn xoá tin đăng này?", preferredStyle: UIAlertController.Style.alert)
			alert.setMessage(font: UIFont.systemFont(ofSize: 16), color: .blue)
			alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
				
				let point = sender.convert(CGPoint.zero, to: self.xeDangBanTableView)
				guard let indexPath1 = self.xeDangBanTableView.indexPathForRow(at: point)
						else {return}
						indexOfFilterXeDangBan = indexPath1.row
						let tinDangHienTai = filterXeDangBan[indexOfFilterXeDangBan]
						try! realm.write{
							realm.delete(tinDangHienTai)
							self.xeDangBanTableView.reloadData()
							self.xeDaBanTableView.reloadData()
					}
				
			}))
			alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
		UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .blue
			self.present(alert, animated: true, completion: nil)
		chonLoaiXeTim = 3
		chonKhoangGiaTim = 3
		chonNamSanXuatTim = 3
		chonHangXeSua = 3
	}
	
	@objc func daBan(_ sender: UIButton) {
		
		let alert = UIAlertController(title: "Lưu ý", message: "Bạn đã bán xong?", preferredStyle: UIAlertController.Style.alert)
		alert.setMessage(font: UIFont.systemFont(ofSize: 16), color: .blue)
		alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
			UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .blue
			let point = sender.convert(CGPoint.zero, to: self.xeDangBanTableView)
			guard let indexPath1 = self.xeDangBanTableView.indexPathForRow(at: point)
			else {return}
			indexOfFilterXeDangBan = indexPath1.row
			let tinDangHienTai = filterXeDangBan[indexOfFilterXeDangBan]
			try! realm.write{
				tinDangHienTai.banHayChua = "Đã bán"
				tinDangHienTai.thoiGianDang = getCurrentDate()
			}
			self.xeDangBanTableView.reloadData()
			self.xeDaBanTableView.reloadData()
			
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		chonLoaiXeTim = 3
		chonKhoangGiaTim = 3
		chonNamSanXuatTim = 3
		chonHangXeSua = 3
		
	}
    @IBAction func goToTrangTruoc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goToSuaTrangCaNhan(_ sender: Any) {
        let vc = SuaTaiKhoanVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func goToSignIn(_ sender: Any) {
        let vc = SignIn()
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
    
    @IBAction func goToThongBao(_ sender: Any) {
        let vc = ThongBaoVC()
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
    
}

class DaBanTableViewCell: UITableViewCell {
    let giaLabel = UILabel()
    let tieuDeLabel = UILabel()
	let ngayBanLabel = UILabel()
    let view = UIView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        giaLabel.translatesAutoresizingMaskIntoConstraints = false
        tieuDeLabel.translatesAutoresizingMaskIntoConstraints = false
		ngayBanLabel.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
 
        contentView.addSubview(giaLabel)
        contentView.addSubview(tieuDeLabel)
		contentView.addSubview(ngayBanLabel)
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            
            tieuDeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            tieuDeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            tieuDeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			
			ngayBanLabel.topAnchor.constraint(equalTo: tieuDeLabel.bottomAnchor, constant: 2),
			ngayBanLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			ngayBanLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            giaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            giaLabel.leadingAnchor.constraint(equalTo: tieuDeLabel.leadingAnchor, constant: 0),
            
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.widthAnchor.constraint(equalToConstant: 380),
            view.heightAnchor.constraint(equalToConstant: 1),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
             ])
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}

