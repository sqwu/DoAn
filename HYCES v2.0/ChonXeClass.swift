//
//  ChonXeClass.swift
//  
//
//  Created by Duong Le on 08/09/2021.
//

import Foundation
import RealmSwift

class ChonXe: Object {
/*1*/ @objc dynamic var hangXe = ""
/*2*/ @objc dynamic var loaiXe = ""
/*3*/ @objc dynamic var namSanXuat = ""
/*4*/ @objc dynamic var khoangGia = ""
/*5*/ @objc dynamic var phienBan = ""
/*6*/ @objc dynamic var giaBan: Int = 0
/*7*/ @objc dynamic var mau = ""
/*8*/ @objc dynamic var soKmDaDi = ""
/*9*/ @objc dynamic var xuatXu = ""
/*10*/  @objc dynamic var tinhTrang = ""
/*11*/  @objc dynamic var hinhAnh1 = ""
/*12*/  @objc dynamic var hinhAnh2 = ""
/*13*/  @objc dynamic var hinhAnh3 = ""
/*14*/  @objc dynamic var hinhAnh4 = ""
/*15*/  @objc dynamic var hinhAnh5 = ""
/*16*/  @objc dynamic var hinhAnh6 = ""
/*17*/  @objc dynamic var tieuDe = ""
/*18*/  @objc dynamic var thoiGianDang = ""
/*19*/  @objc dynamic var diaDiem = ""
/*20*/  @objc dynamic var taiKhoanDang = ""
/*21*/  @objc dynamic var moiHayCu = ""
/*22*/  @objc dynamic var hopSo = ""
/*23*/  @objc dynamic var nhienLieu = ""
/*24*/  @objc dynamic var anHien = ""
/*25*/  @objc dynamic var banHayChua = ""
/*26*/  @objc dynamic var taiKhoan = ""
/*27*/  @objc dynamic var id = ""
        override class func primaryKey() -> String? {
           return "id"
       }
}

class TaiKhoan: Object  {
    @objc dynamic var email: String = ""
    var xe = List<ChonXe>()
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""

    @objc dynamic var diemDau: Double = 0
    @objc dynamic var diemCuoi: Double = 0
    @objc dynamic var alpha: Float = 0.5
    @objc dynamic var theme: Int  = 0
//
//    @objc dynamic var điemDanhGia: Int  = 0
//    @objc dynamic var tongDanhGia: Int  = 0
    @objc dynamic var id: String = ""
    override class func primaryKey() -> String? {
       return "id"
    }
}

class ColorClass: Object {
    let colorComponents = List<Float>()
    @objc dynamic var id: String = ""
    @objc dynamic var taiKhoan = ""
    override class func primaryKey() -> String? {
        return "id"}
}
