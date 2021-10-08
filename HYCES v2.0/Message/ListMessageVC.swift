//
//  ListMessageVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 12/09/2021.
//

import UIKit
import MessageKit

class ListMessageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var backBtt: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: Gradient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientView(View: gradientView)
        if abc1?.theme == 0 {
            super.view.backgroundColor = .white
            gradientView.isHidden = false
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .white
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
            
        }
        else {
        super.view.backgroundColor = .black
            gradientView.isHidden = true
            UITableViewCell.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UITableView.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = grayBackground
            UIButton.appearance(whenContainedInInstancesOf: [UIView.self]).backgroundColor = .clear
                   }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stringArray = ["Dương Lê", "Nguyễn Ngọc", "Crystal Trần", "David Moyes", "Dung Nguyễn"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stringArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator
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
        tableView.deselectRow(at: indexPath, animated: true)
        let messageVC = MessageVC()
        messageVC.modalPresentationStyle = .fullScreen
        self.present(messageVC, animated: true, completion: nil)
    }
    
    
    @IBAction func goToBanXeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
