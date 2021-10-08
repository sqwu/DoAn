//
//  DanhSachXeCuTableViewCell.swift
//  HYCES v2.0
//
//  Created by Duong Le on 11/09/2021.
//

import UIKit

class DanhSachXeCuTableViewCell: UITableViewCell {
    @IBOutlet weak var anhXeImageView: UIImageView!
    @IBOutlet weak var tieuDeLabel: UILabel!
    @IBOutlet weak var phienBanVaMauLabel: UILabel!
    @IBOutlet weak var NamVaSoKmLabel: UILabel!
    @IBOutlet weak var giaLabel: UILabel!
    @IBOutlet weak var thoiGianDangLabel: UILabel!
    @IBOutlet weak var diaDiemLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()

   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
