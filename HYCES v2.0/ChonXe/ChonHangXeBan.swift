//
//  ChonHangXeBan.swift
//  HYCES v2.0
//
//  Created by Duong Le on 14/09/2021.
//

import UIKit
import RealmSwift

class ChonHangXeBan: UIViewController {
    @IBOutlet weak var hangXeTableView: UITableView!
    @IBOutlet weak var backBtt: UIButton!

    var cacThuocTinhChonXe: Results<ChonXe>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    if abc1?.theme == 0 {
        super.view.backgroundColor = .white
        UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
        
    }
    else {
    super.view.backgroundColor = .black
        UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
        UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
               }
        
        hangXeTableView.delegate = self
        hangXeTableView.dataSource = self
        hangXeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    @IBAction func goToBanXeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func luuHangXe(name: String) {
        let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
    try! realm.write {
       abc.hangXe = name
       }
    }
    func luuLoaiXe(name: String) {
      let abc = cacThuocTinhChonXeBan[cacThuocTinhChonXeBan.count - 1]
      try! realm.write {
         abc.loaiXe = name
         }
       }
    
}
extension ChonHangXeBan: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hangXeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if chonHangXeSua == 1
        { let name = hangXeList[indexPath.row]
            luuHangXe(name: name)
            luuLoaiXe(name: "Chọn Loại Xe")
        }
        
        else if chonHangXeSua == 3
        {suaHangXe = hangXeList[indexPath.row]
         suaLoaiXe = "Chọn Loại Xe"
        }
        self.dismiss(animated: true, completion: nil)
    }

}


