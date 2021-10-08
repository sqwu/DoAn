//
//  ChonNamSanXuatBan.swift
//  HYCES v2.0
//
//  Created by Duong Le on 15/09/2021.
//

import UIKit
import RealmSwift

class ChonNamSanXuatBan: UIViewController {

    @IBOutlet weak var backToBanXeVC: UIButton!
    @IBOutlet weak var namSanXuatTableView: UITableView!
    
    var cacThuocTinhChonXe: Results<ChonXe>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        namSanXuatTableView.delegate = self
        namSanXuatTableView.dataSource = self
        namSanXuatTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    @IBAction func backToBanXe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func luuNamSanXuat(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
    try! realm.write {
       abc.namSanXuat = name

       }
    }
}
extension ChonNamSanXuatBan: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cacNamSanXuat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cacNamSanXuat[indexPath.row]
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
      if chonNamSanXuatTim == 1 {
        let name = cacNamSanXuat[indexPath.row]
        luuNamSanXuat(name: name)}
      else if chonNamSanXuatTim == 2 {
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        namSanXuat = (currentCell.textLabel?.text)!
        locLabelTren = [timHangXe, timLoaiXe, namSanXuat, timKhoangGia, "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
      }
      else if chonNamSanXuatTim == 3 {
        suaNamSanXuat = cacNamSanXuat[indexPath.row]
      }
        
        self.dismiss(animated: true, completion: nil)
    }
}

