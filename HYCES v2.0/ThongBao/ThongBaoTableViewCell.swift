//
//  ThongBaoTableViewCell.swift
//  HYCES v2.0
//
//  Created by Duong Le on 19/09/2021.
//

import UIKit

class ThongBaoTableViewCell: UITableViewCell {
    @IBOutlet weak var noiDungLabel: UILabel!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var thoiGianLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var chamTron: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        idLabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
