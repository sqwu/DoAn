//
//  MessageVC.swift
//  HYCES v2.0
//
//  Created by Duong Le on 12/09/2021.
//

import UIKit
import MessageKit
struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}


class MessageVC: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentsender = Sender(senderId: "nguoiMua", displayName: "Hoàng Ngân")
    let me = Sender(senderId: "toi", displayName: "Dương Lê")
    var chatMessage = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Setup Layout
        let tenNguoiChatLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Dương Lê"
            label.font = UIFont.boldSystemFont(ofSize: 24.0)
            return label
        }()
        let backButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("❮", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
            return button
        }()
        super.view.addSubview(backButton)
        super.view.addSubview(tenNguoiChatLabel)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 38).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        tenNguoiChatLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        tenNguoiChatLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70).isActive = true
       
        //MARK: Setup Back button
        let tap = UITapGestureRecognizer(target: self, action: #selector(backToListMessage))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tap)
        
        
        
        //MARK: Setup Chat
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.contentInset.top = 70
        chatMessage.append(Message(sender: currentsender, messageId: "1", sentDate: Date(), kind: .text("Tôi muốn hỏi mua xe")))
        chatMessage.append(Message(sender: me, messageId: "2", sentDate: Date(), kind: .text("Bạn muốn mua xe gì")))
        chatMessage.append(Message(sender: currentsender, messageId: "3", sentDate: Date().addingTimeInterval(70000), kind: .text("Xe Huyndai bạn ơi")))
        chatMessage.append(Message(sender: me, messageId: "4", sentDate: Date().addingTimeInterval(65000), kind: .text("Tài chính của bạn khoảng bao nhiêu")))
        chatMessage.append(Message(sender: currentsender, messageId: "5", sentDate: Date().addingTimeInterval(60000), kind: .text("Nhiều nhất là 500 triệu bạn ạ")))
        chatMessage.append(Message(sender: me, messageId: "6", sentDate: Date().addingTimeInterval(55000), kind: .text("Để tôi tìm, bạn đợi chút nhé")))
    }
    
    func currentSender() -> SenderType {
    return    currentsender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return chatMessage[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        chatMessage.count
    }


    //MARK: func for backbutton
    @objc func backToListMessage(sender:UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
//        let listMessageVc = ListMessageVC()
//        listMessageVc.modalPresentationStyle = .fullScreen
//        self.present(listMessageVc, animated: true, completion: nil)
    }
}
