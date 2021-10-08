//
//  XeDangBanTableViewCell.swift
//  HYCES v2.0
//
//  Created by Duong Le on 22/09/2021.
//

import UIKit

class XeDangBanTableViewCell: UITableViewCell {

    @IBOutlet weak var anhXeImage: UIImageView!
    @IBOutlet weak var suaBtt: UIButton!
    @IBOutlet weak var xoaBtt: UIButton!
    @IBOutlet weak var daBanBtt: UIButton!
    @IBOutlet weak var moreBtt: UIButton!
    
    @IBOutlet weak var thuocTinhLabel: UILabel!
    @IBOutlet weak var giaLabel: UILabel!
    @IBOutlet weak var tieuDeLabel: UILabel!
    var suaBttState: Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
       
        suaBtt.isHidden = true
        xoaBtt.isHidden = true
        daBanBtt.isHidden = true
        if taiKhoanState == 2 {moreBtt.isHidden = true}
    }
    @IBAction func moreBttDidTap(_ sender: Any) {
        if abc1?.theme == 0 {
            suaBtt.backgroundColor = .black
            xoaBtt.backgroundColor = .black
            daBanBtt.backgroundColor = .black
            suaBtt.setTitleColor(.white, for: .normal)
            xoaBtt.setTitleColor(.white, for: .normal)
            daBanBtt.setTitleColor(.white, for: .normal)
        }
        else {
            suaBtt.backgroundColor = .white
            xoaBtt.backgroundColor = .white
            daBanBtt.backgroundColor = .white
            suaBtt.setTitleColor(.black, for: .normal)
            xoaBtt.setTitleColor(.black, for: .normal)
            daBanBtt.setTitleColor(.black, for: .normal)      }
        
        if suaBttState == true {
            suaBtt.isHidden = false
            xoaBtt.isHidden = false
            daBanBtt.isHidden = false
            
        } else {
            suaBtt.isHidden = true
            xoaBtt.isHidden = true
            daBanBtt.isHidden = true
        }
        suaBttState = !suaBttState
    }
    @IBAction func suaTinDidTap(_ sender: Any) {
        suaBtt.isHidden = true
        xoaBtt.isHidden = true
        daBanBtt.isHidden = true
        suaBttState = true
    }
    
    @IBAction func xoaTinDidTap(_ sender: Any) {
        suaBtt.isHidden = true
        xoaBtt.isHidden = true
        daBanBtt.isHidden = true
        suaBttState = true
    }
    
    @IBAction func daBanDidTap(_ sender: Any) {
        suaBtt.isHidden = true
        xoaBtt.isHidden = true
        daBanBtt.isHidden = true
        suaBttState = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
