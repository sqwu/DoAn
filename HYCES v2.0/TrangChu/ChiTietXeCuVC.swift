//
//  ChiTietXeCuVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 12/09/2021.
//

import UIKit
import RealmSwift
import Firebase

class ChiTietXeCuVC: UIViewController {
    @IBOutlet weak var tieuDeLabel: UILabel!
    @IBOutlet weak var giaLabel: UILabel!
    @IBOutlet weak var avatarBtt: UIButton!
    @IBOutlet weak var thoiGianDangLabel: UILabel!
    @IBOutlet weak var diaDiemLabel: UILabel!
    @IBOutlet weak var tenUserLabel: UILabel!
    
    
    
    @IBOutlet weak var dangTinBtt: UIButton!
    @IBOutlet weak var callBtt: UIButton!
    @IBOutlet weak var backBtt: UIButton!
    @IBOutlet weak var messageBtt: UIButton!
    @IBOutlet weak var goiDienLabel: UILabel!
    @IBOutlet weak var nhanTinLabel: UILabel!
    
    @IBOutlet weak var chiTietXeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var wallPaperImgView: UIImageView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var thongTinView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientView: Gradient!
    @IBOutlet weak var shareBtt: UIButton!
    
    //MARK: set statusbar dark or light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if abc1?.theme == 0 {return .darkContent} else { return .lightContent}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        collectionView.reloadData()
        setUiviewBorder(uiview: thongTinView)
//        let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
//        tenUserLabel.text = user?.displayName
        if dangTinState == 1 { //vào từ trang bán xe thì ko ẩn nút đăng tin mà ẩn nút gọi điện nhắn tin
            callBtt.isHidden = true
            messageBtt.isHidden = true
            dangTinBtt.isHidden = false
            dangTinBtt.backgroundColor = .white
            dangTinBtt.setTitleColor(.black, for: .normal)
            avatarBtt.isUserInteractionEnabled = false
            goiDienLabel.isHidden = true
            nhanTinLabel.isHidden = true
        }
        else if dangTinState == 2  //vào từ trang chủ thì ẩn nút đăng tin
        { dangTinBtt.isHidden = true}
        else {
            callBtt.isHidden = true
            messageBtt.isHidden = true
            dangTinBtt.isHidden = true
            dangTinBtt.backgroundColor = .white
            dangTinBtt.setTitleColor(.black, for: .normal)
            avatarBtt.isUserInteractionEnabled = false
            goiDienLabel.isHidden = true
            nhanTinLabel.isHidden = true
            
        }
        //MARK: setup layout SlideAnhXeCuCollectionView
        let nib = UINib(nibName: "SlideAnhXeCuCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "SlideAnhXeCuCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      fetchData()
    setGradientView(View: gradientView)
        if abc1?.theme == 0 { wallPaperImgView.image = UIImage(named: wallpaperName)
            wallPaperImgView.isHidden = true
            wallPaperImgView.alpha = wallpaperAlpha
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            thongTinView.backgroundColor = .white
            scrollContentView.backgroundColor = .white
            scrollView.backgroundColor = .white

        } else {
            wallPaperImgView.isHidden = true
            super.view.backgroundColor = .black
            gradientView.isHidden = true
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .white
            UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            thongTinView.backgroundColor = grayBackground
            scrollContentView.backgroundColor = grayBackground
            scrollView.backgroundColor = grayBackground

            
        }
    }
    
    @IBAction func avatarBttDidTap(_ sender: Any) {
       guard let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey) else {return}
        let xyz = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc.taiKhoan)
       guard let xyz1 = Auth.auth().currentUser?.uid else {return}
        if xyz1 == xyz?.id {return}
        tenUserLabel.text = xyz?.name
        taiKhoanState = 2
        let VC = TaiKhoanVC()
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func messageDidTap(_ sender: Any) {
        let VC = MessageVC()
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
        
    }
    @IBAction func callDidTap(_ sender: Any) {
         let application = UIApplication.shared
    if  let phoneURL = URL(string: "tel://0916143730") {
        if application.canOpenURL(phoneURL) {
            application.open(phoneURL, options: [:], completionHandler: nil)
        } else {
        
        }
    }
}
    @IBAction func goToTaiKhoanVC(_ sender: UITapGestureRecognizer) {
        taiKhoanState = 1
        let VC = TaiKhoanVC()
        VC.modalTransitionStyle = .crossDissolve
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func dangTinNgayDidTap(_ sender: Any) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        noiDungArray.insert("Chúc mừng bạn! Tin đăng \(abc.tieuDe) đã được duyệt thành công", at: 0)

        thoiGianArray.insert("\(abc.thoiGianDang.suffix(5))", at: 0)
        imageArrayTb.insert(UIImage(named: "avatar2")!, at: 0)
        idArray.insert("\(abc.id)", at: 0)
        thongBaoMoi += 1
                let VC = TrangChuVC()
                VC.modalTransitionStyle = .crossDissolve
                VC.modalPresentationStyle = .fullScreen
                self.present(VC, animated: true, completion: nil)
    }
    @IBAction func backToTrangChu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func shareBtt(_ sender: Any) {
        let items = [URL(string: "https://www.apple.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    
    private func fetchData() {
//        let currentUser = Auth.auth().currentUser

        giaLabel.textColor = .systemTeal
        let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
        let xyz = realm.object(ofType: TaiKhoan.self, forPrimaryKey: abc?.taiKhoan)
        var ref = storageRef.child("Avatar/\(xyz?.email ?? "")")
        ref.downloadURL(completion: { (url, error) in
                            if (error == nil) {
                                self.avatarBtt.sd_setImage(with: url, for: .normal, completed: nil)
                                }
                             else {
                           // Do something if error
                            }
        }
        )
        tenUserLabel.text = xyz?.name
        let soKmDaDiInt = Int(abc?.soKmDaDi ?? "0")!.formattedWithSeparator
        let giaBanInt = abc?.giaBan.formattedWithSeparator
        thoiGianDangLabel.text = abc?.thoiGianDang
        tieuDeLabel.text = abc?.tieuDe
        giaLabel.text = "Giá: \(giaBanInt!) đ"
        diaDiemLabel.text = abc?.diaDiem
        chiTietXeLabel.text =
            """
            THÔNG TIN CHI TIẾT:
                        🚗🚗🚗
            \(abc?.tinhTrang ?? "")
            Hãng xe:           \(abc?.hangXe ?? "")
            Loại xe:             \(abc?.loaiXe ?? "")
            Tình trạng:        \(abc?.moiHayCu ?? "")
            Số km đã đi:     \(soKmDaDiInt) km
            Xuất xứ:            \(abc?.xuatXu ?? "")
            Năm sản xuất:  \(abc?.namSanXuat ?? "")
            Màu:                  \(abc?.mau ?? "")
            Phiên bản:        \(abc?.phienBan ?? "")
            Nhiên liệu:        \(abc?.nhienLieu ?? "")
            Hộp số:             \(abc?.hopSo ?? "")
            """
    }
    



}
extension ChiTietXeCuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideAnhXeCuCollectionViewCell", for: indexPath) as! SlideAnhXeCuCollectionViewCell
        let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
        let imageArray: [String] = [(abc?.hinhAnh1)!, (abc?.hinhAnh2)!, (abc?.hinhAnh3)!, (abc?.hinhAnh4)!, (abc?.hinhAnh5)!, (abc?.hinhAnh6)!]
        pageControl.numberOfPages = imageArray.count
        //pageControl.backgroundStyle = .prominent
        pageControl.allowsContinuousInteraction = true
        cell.image.image = UIImage(named: imageArray[indexPath.row])
        pageControl.currentPage = indexPath.row

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SlideAnhFullScreenVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
}
//extension ChiTietXeCuVC: UIScrollViewDelegate {
//    
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        // Calculate the new page index depending on the content offset.
//        let currentPage = floor(scrollView.contentOffset.x / scrollView.bounds.size.width)
//        // Set the new page index to the page control.
//        pageControl.currentPage = Int(currentPage)
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        scrollViewDidEndScrollingAnimation(scrollView)
//    }
//}
