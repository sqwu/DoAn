//
//  ChonLoaiXeBan.swift
//  HYCES v2.0
//
//  Created by Duong Le on 14/09/2021.
//

import UIKit
import RealmSwift

class ChonLoaiXeBan: UIViewController {
    @IBOutlet weak var backToBanXe: UIButton!
    @IBOutlet weak var loaiXeTableView: UITableView!
    var danhSachHangXeDuocChon: [String]!
    
    var cacThuocTinhChonXe: Results<ChonXe>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaiXeTableView.delegate = self
        loaiXeTableView.dataSource = self
        loaiXeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if chonLoaiXeTim == 1 { // vào từ bán xe
            
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1].hangXe
            switch abc {
            case "Ford":
                danhSachHangXeDuocChon = loaiXeFord
            case "Mecedes":
                danhSachHangXeDuocChon = loaiXeMec
            case "Huyndai":
                danhSachHangXeDuocChon = loaiXeHuyndai
            case "Audi":
                danhSachHangXeDuocChon = loaiXeAudi
            case "BMW":
                danhSachHangXeDuocChon = loaiXeBMW
            case "Chevrolet":
                danhSachHangXeDuocChon = loaiXeChevrolet
            case "Honda":
                danhSachHangXeDuocChon = loaiXeHonda
            case "Isuzu":
                danhSachHangXeDuocChon = loaiXeIsuzu
            case "Kia":
                danhSachHangXeDuocChon = loaiXeKia
            case "Lexus":
                danhSachHangXeDuocChon = loaiLexus
            case "Mazda":
                danhSachHangXeDuocChon = loaiMazda
            case "Mitsubishi":
                danhSachHangXeDuocChon = loaiMitsubishi
            case "Nissan":
                danhSachHangXeDuocChon = loaiNissan
            case "Toyota":
                danhSachHangXeDuocChon = loaiToyota
            case "Vinfast":
                danhSachHangXeDuocChon = loaiVinfast
            default:
                danhSachHangXeDuocChon = loaiXeKhac
            }
        }
        else if chonLoaiXeTim == 2 { //vào từ trang chủ

                switch timHangXe {
                case "Ford":
                    danhSachHangXeDuocChon = loaiXeFord
                case "Mecedes":
                    danhSachHangXeDuocChon = loaiXeMec
                case "Huyndai":
                    danhSachHangXeDuocChon = loaiXeHuyndai
                case "Audi":
                    danhSachHangXeDuocChon = loaiXeAudi
                case "BMW":
                    danhSachHangXeDuocChon = loaiXeBMW
                case "Chevrolet":
                    danhSachHangXeDuocChon = loaiXeChevrolet
                case "Honda":
                    danhSachHangXeDuocChon = loaiXeHonda
                case "Isuzu":
                    danhSachHangXeDuocChon = loaiXeIsuzu
                case "Kia":
                    danhSachHangXeDuocChon = loaiXeKia
                case "Lexus":
                    danhSachHangXeDuocChon = loaiLexus
                case "Mazda":
                    danhSachHangXeDuocChon = loaiMazda
                case "Mitsubishi":
                    danhSachHangXeDuocChon = loaiMitsubishi
                case "Nissan":
                    danhSachHangXeDuocChon = loaiNissan
                case "Toyota":
                    danhSachHangXeDuocChon = loaiToyota
                case "Vinfast":
                    danhSachHangXeDuocChon = loaiVinfast
                default:
                    danhSachHangXeDuocChon = loaiXeKhac
                }

        }
        else if chonLoaiXeTim == 3 { // vào từ sửa xe

            switch suaHangXe {
                case "Ford":
                    danhSachHangXeDuocChon = loaiXeFord
                case "Mecedes":
                    danhSachHangXeDuocChon = loaiXeMec
                case "Huyndai":
                    danhSachHangXeDuocChon = loaiXeHuyndai
                case "Audi":
                    danhSachHangXeDuocChon = loaiXeAudi
                case "BMW":
                    danhSachHangXeDuocChon = loaiXeBMW
                case "Chevrolet":
                    danhSachHangXeDuocChon = loaiXeChevrolet
                case "Honda":
                    danhSachHangXeDuocChon = loaiXeHonda
                case "Isuzu":
                    danhSachHangXeDuocChon = loaiXeIsuzu
                case "Kia":
                    danhSachHangXeDuocChon = loaiXeKia
                case "Lexus":
                    danhSachHangXeDuocChon = loaiLexus
                case "Mazda":
                    danhSachHangXeDuocChon = loaiMazda
                case "Mitsubishi":
                    danhSachHangXeDuocChon = loaiMitsubishi
                case "Nissan":
                    danhSachHangXeDuocChon = loaiNissan
                case "Toyota":
                    danhSachHangXeDuocChon = loaiToyota
                case "Vinfast":
                    danhSachHangXeDuocChon = loaiVinfast
                default:
                    danhSachHangXeDuocChon = loaiXeKhac
                }

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    if abc1?.theme == 0 {
        super.view.backgroundColor = .white
        UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
        UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
        
    }
    else {
    super.view.backgroundColor = .black
        UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
        UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
               }
    }

    @IBAction func goBackToBanXe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
  func luuLoaiXe(name: String) {
    let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
    try! realm.write {
       abc.loaiXe = name
       }
     }
}
extension ChonLoaiXeBan: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        danhSachHangXeDuocChon.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = danhSachHangXeDuocChon[indexPath.row]
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
      if chonLoaiXeTim == 1 {
        let name = danhSachHangXeDuocChon[indexPath.row]
        luuLoaiXe(name: name)
//        let banXeVC = BanXeVC()
//        banXeVC.modalPresentationStyle = .fullScreen
//         self.present(banXeVC, animated: true, completion: nil)
        
      }
        
        else if chonLoaiXeTim == 2 {
            let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
            let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
            timLoaiXe = (currentCell.textLabel?.text)!
            locLabelTren = [timHangXe, timLoaiXe, namSanXuat , timKhoangGia, "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
        }
        
        else if chonLoaiXeTim == 3 {
            suaLoaiXe = danhSachHangXeDuocChon[indexPath.row]
        }
        self.dismiss(animated: true, completion: nil)
        }

    }


//            if abc == "Ford" {
//            danhSachHangXeDuocChon = loaiXeFord}
//            else if abc == "Mecedes" {
//            danhSachHangXeDuocChon = loaiXeMec}
//            else if abc == "Huyndai" {
//            danhSachHangXeDuocChon = loaiXeHuyndai}
//            else if abc == "Audi" {
//            danhSachHangXeDuocChon = loaiXeAudi}
//            else if abc == "BMW" {
//            danhSachHangXeDuocChon = loaiXeBMW}
//            else if abc == "Chevrolet" {
//            danhSachHangXeDuocChon = loaiXeChevrolet}
//            else if abc == "Honda" {
//            danhSachHangXeDuocChon = loaiXeHonda}
//            else if abc == "Isuzu" {
//            danhSachHangXeDuocChon = loaiXeIsuzu}
//            else if abc == "Kia" {
//            danhSachHangXeDuocChon = loaiXeKia}
//            else if abc == "Lexus" {
//            danhSachHangXeDuocChon = loaiLexus}
//            else if abc == "Mazda" {
//            danhSachHangXeDuocChon = loaiMazda}
//            else if abc == "Mitsubishi" {
//            danhSachHangXeDuocChon = loaiMitsubishi}
//            else if abc == "Nissan" {
//            danhSachHangXeDuocChon = loaiNissan}
//            else if abc == "Toyota" {
//            danhSachHangXeDuocChon = loaiToyota}
//            else if abc == "Vinfast" {
//            danhSachHangXeDuocChon = loaiVinfast}
//
