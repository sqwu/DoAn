//
//  SlideAnhFullScreenVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 19/09/2021.
//

import UIKit
import RealmSwift

class SlideAnhFullScreenVC: UIViewController {
    @IBOutlet weak var slideAnhCollectionView: UICollectionView!
    @IBOutlet weak var backBtt: UIButton!
    var stringArray: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        backBtt.setTitleColor(.white, for: .normal)
        let abc = realm.object(ofType: ChonXe.self, forPrimaryKey: primaryKey)
        stringArray = [abc?.hinhAnh1 ?? "", abc?.hinhAnh2 ?? "", abc?.hinhAnh3 ?? "", abc?.hinhAnh4 ?? "", abc?.hinhAnh5 ?? "", abc?.hinhAnh6 ?? "" ]
        slideAnhCollectionView.backgroundColor = .black
        slideAnhCollectionView.delegate = self
        slideAnhCollectionView.dataSource = self
//        let nib = UINib(nibName: "SlideAnhCollectionViewCell", bundle: nil)
//        slideAnhCollectionView.register(nib, forCellWithReuseIdentifier: "SlideAnhCollectionViewCell")
        slideAnhCollectionView.register(SlideAnhCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
extension SlideAnhFullScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SlideAnhCollectionViewCell
        cell.image.image = UIImage(named: stringArray[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

}
class SlideAnhCollectionViewCell: UICollectionViewCell {
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    func addViews(){
        backgroundColor = UIColor.black
        addSubview(image)
 
                image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
                image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
                image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
        }


