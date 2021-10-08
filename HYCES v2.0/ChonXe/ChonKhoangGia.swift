//
//  ChonKhoangGia.swift
//  HYCES v2.0
//
//  Created by Duong Le on 10/09/2021.
//

import UIKit
import RealmSwift

class ChonKhoangGia: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backToTrangChuVCBtt: UIButton!
   
    var cacThuocTinhChonXe: Results<ChonXe>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    @IBAction func goBackToTrangChuVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func luuKhoangGia(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
        try! realm.write {
            abc.khoangGia = name
            
        }
    }
    
}
extension ChonKhoangGia: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cacKhoangGia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cacKhoangGia[indexPath.row]
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
        if chonKhoangGiaTim == 1 {
        let name = cacKhoangGia[indexPath.row]
            luuKhoangGia(name: name)
            
        }
   
        
        else {
          let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
          timKhoangGia = (currentCell.textLabel?.text)!
          locLabelTren = [timHangXe, timLoaiXe, namSanXuat, timKhoangGia, "Phiên bản ▼", "Màu ▼", "Xuất xứ ▼", "Tình trạng ▼"]
        }
            self.dismiss(animated: true, completion: nil)
    }
}
