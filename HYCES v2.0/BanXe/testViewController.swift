//
//  testViewController.swift
//  HYCES v2.0
//
//  Created by Duong Le on 21/09/2021.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase



class testViewController: UIViewController {
    var db: Firestore!
    var finalResult: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
      addDanhGia()
 duongle()
        let abcde = finalResult + 5
        print("abv là \(abcde)")
//        getDanhGia()
//        addAdaLovelace()
//        addAlanTuring()
//        getCollection()

        
    }
    func addDanhGia() {
        let user = Auth.auth().currentUser
        guard let userEmail = user?.email else {return}
        db.collection("danhGia").document("\(userEmail)").setData([
            "diemDanhGia": 7,
            "TongDanhGia": 4,
        ], merge: true)
    }
    
//    private func getDanhGia() {
//
//        db.collection("danhGia").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//    }
//
//func getDocument1() -> Double {
//        let user = Auth.auth().currentUser
//        guard let userEmail = user?.email else {return 0}
//        let docRef = db.collection("danhGia").document("\(userEmail)")
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//             if let dataDescription = document.data().map{$0["diemDanhGia"]!}
//             {self.finalResult = dataDescription as! Double} else {return}
//            } else {
//                print("Document does not exist")
//            }
//
//        }
//        return finalResult
//    }
    
    
    private func addAdaLovelace() {
        // [START add_ada_lovelace]
        // Add a new document with a generated ID

        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
  //          "middle": "dung",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        // [END add_ada_lovelace]
    }
   

    private func addAlanTuring() {
           var ref: DocumentReference? = nil

           // [START add_alan_turing]
           // Add a second document with a generated ID.
        ref = db.collection("users").addDocument(data: [
               "first": "Alan123",
               "middle": "Mathison",
               "last": "Turing",
               "born": 1912
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(ref!.documentID)")
               }
           }
           // [END add_alan_turing]
       }
    
    
    
func getCollection() {
        // [START get_collection]
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        // [END get_collection]
    }
    func  duongle() -> Double {
        let user = Auth.auth().currentUser
        guard let userEmail = user?.email else {return 0}
        let docRef = db.collection("danhGia").document("\(userEmail)")

        docRef.getDocument(source: .cache) { (document, error) in
            if let document = document {
                self.finalResult = document.get("diemDanhGia") as! Double
                print("tôi là \(self.finalResult)")
            } else {
                print("Document does not exist in cache")
            }
        }
        return finalResult
    }

}



