//
//  ChattingViewController.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 17..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit
import Firebase
import FirebaseStorage
import Alamofire
import NVActivityIndicatorView

class ChattingViewController: JSQMessagesViewController {
    
    var activityView: NVActivityIndicatorView!
    var avatarDict: [String: JSQMessagesAvatarImage] = [:]
    var messageRef = Database.database().reference().child("Messages")
    var messages = [JSQMessage]()
    let profileService: ProfileServiceType = ProfileService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let currentUserToken = UserDefaults.standard.string(forKey: "CurrentUserToken")
        if let currentUser = currentUserToken {
            self.senderId = currentUser
            self.senderDisplayName = ""
        }
        
        setupNavigation()
        setupActivityIndicator()
//        observeUsers()
        fetchProfile()
        observeMessage()
        
        activityView.startAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupActivityIndicator() {
        activityView = NVActivityIndicatorView(frame: CGRect(x: self.view.center.x - 50, y: self.view.center.y - 50, width: 100, height: 100), type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0/255.0, green: 132/255.0, blue: 137/255.0, alpha: 1), padding: 25)
        
        activityView.backgroundColor = .white
        activityView.layer.cornerRadius = 10
        self.view.addSubview(activityView)
    }
    
    private func setupNavigation() {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "arrow_left_black"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.setLeftBarButton(leftItem, animated: true)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length)
        let bottom = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        if #available(iOS 11.0, *) {
            let leading = collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            let trailing = collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            NSLayoutConstraint.activate([top, bottom, trailing, leading])
        } else {
            let leading = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailing = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            NSLayoutConstraint.activate([top, bottom, trailing, leading])
        }
    }
    
//    func observeUsers() {
//        let currentUserToken = UserDefaults.standard.string(forKey: "CurrentUserToken")
//
//
//
//        Database.database().reference().child("Users").child(currentUserToken!).observe(DataEventType.value) { (snapshot) in
//            if let dict = snapshot.value as? [String:Any] {
//                let avartarUrl = dict["profileImage"] as! String
//                self.setupAvatar(url: avartarUrl, messageId: currentUserToken!)
//
//                if let currentUser = currentUserToken {
//                    self.senderId = currentUser
//                    self.senderDisplayName = "\(dict["firstName"] as! String)"
//                }
//            }
//        }
//    }
    
    private func fetchProfile() {
        
        profileService.fetchProfile(token: UserDefaults.standard.string(forKey: "CurrentUserToken")!) { (result) in
            switch result {
            case .success(let userInfo):
                self.activityView.stopAnimating()
                
                
                let avartarUrl = userInfo.profileImage
                self.setupAvatar(url: avartarUrl!, messageId: UserDefaults.standard.string(forKey: "CurrentUserToken")!)
                
                self.senderId = UserDefaults.standard.string(forKey: "CurrentUserToken")!
                self.senderDisplayName = userInfo.firstName
                
            case .failure(let error):
                self.activityView.stopAnimating()
                print(error)
            }
        }
    }
    
    func setupAvatar(url: String, messageId: String) {
        if url != "" {
            let fileUrl = URL(string: url)

            let data = try? Data(contentsOf: fileUrl!)
            let image = UIImage(data: data!)
            let userImg = JSQMessagesAvatarImageFactory.avatarImage(with: image, diameter: 30)
            avatarDict[messageId] = userImg
        } else {
            avatarDict[messageId] = JSQMessagesAvatarImageFactory.avatarImage(withPlaceholder: UIImage(named: "profile"), diameter: 30)
        }
        
        collectionView.reloadData()
    }
    
    func observeMessage() {
        messageRef.observe(DataEventType.childAdded) { (snapshot) in
            self.activityView.stopAnimating()
            
            if let dic = snapshot.value as? [String : Any] {
                let mediaType = dic["MediaType"] as! String
                let senderId = dic["senderId"] as! String
                let senderName = dic["senderName"] as! String
                
                
                if mediaType == "TEXT" {
                    let text = dic["text"] as? String
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
                } else if mediaType == "PHOTO" {
                    let fileUrl = dic["fileUrl"] as! String
                    let url = URL(string: fileUrl)
                    let data = try! Data(contentsOf: url!)
                    let picture = UIImage(data: data)
                    let photo = JSQPhotoMediaItem(image: picture)
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: photo))
                    
                    if self.senderId == senderId {
                        photo?.appliesMediaViewMaskAsOutgoing = true
                    } else {
                        photo?.appliesMediaViewMaskAsOutgoing = false
                    }
                } else if mediaType == "VIDEO" {
                    let fileUrl = dic["fileUrl"] as! String
                    let video = URL(string: fileUrl)
                    let videoItem = JSQVideoMediaItem(fileURL: video, isReadyToPlay: true)
                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: videoItem))
                    
                    if self.senderId == senderId {
                        videoItem?.appliesMediaViewMaskAsOutgoing = true
                    } else {
                        videoItem?.appliesMediaViewMaskAsOutgoing = false
                    }
                }
                
                self.collectionView.reloadData()
            }
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let newMessage = messageRef.childByAutoId()
        let messageData = ["text": text, "senderId":senderId, "senderName":senderDisplayName, "MediaType":"TEXT"]
        newMessage.setValue(messageData)
        
        self.finishSendingMessage()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("didPressAccessoryButton")
        
        let sheetVC = UIAlertController(title: "Media", message: "전송할 사진을 골라주세요", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
            
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (alert) in
            self.getMediaFrom(type: kUTTypeImage as String)
        }
        
        let videoLibrary = UIAlertAction(title: "Video Library", style: .default) { (alert) in
            self.getMediaFrom(type: kUTTypeMovie as String)
        }
        
        sheetVC.addAction(cancel)
        sheetVC.addAction(photoLibrary)
        sheetVC.addAction(videoLibrary)
        present(sheetVC, animated: true, completion: nil)

    }
    
    func getMediaFrom(type: String) {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.row]
        
        if message.senderId == self.senderId {
            let bubbleFactory = JSQMessagesBubbleImageFactory()
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 0/255, green: 132/255.0, blue: 137/255.0, alpha: 1))
        } else {
            
            let bubbleFactory = JSQMessagesBubbleImageFactory()
            return bubbleFactory?.incomingMessagesBubbleImage(with: UIColor(red: 200/255, green: 200/255.0, blue: 200/255.0, alpha: 1))
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.row]
        return avatarDict[message.senderId]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of item: \(messages.count)")
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        print("didTapMessageBubbleAt \(indexPath.row)")
        
        let message = messages[indexPath.row]
        if message.isMediaMessage {
            if let mediaItem = message.media as? JSQVideoMediaItem {
                let player = AVPlayer(url: mediaItem.fileURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true, completion: nil)
            }
        }
    }
    
    private func sendMedia(picture: UIImage?, video: URL?) {
        print(Storage.storage().reference())
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.string(from: date)
        
        if let picture = picture {
            let filePath = "\(Date.timeIntervalSinceReferenceDate)"
            let data = UIImageJPEGRepresentation(picture, 0.5)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            Storage.storage().reference().child(senderId).child(filePath).putData(data!, metadata: metadata) { (meta, err) in
                if err != nil {
                    print(err!.localizedDescription)
                    return
                }
                
                Storage.storage().reference().child(self.senderId).child(filePath).downloadURL(completion: { (url, err) in
                    if err != nil {
                        print(err!.localizedDescription)
                        return
                    }
                    
                    let newMessage = self.messageRef.childByAutoId()
                    let messageData = ["fileUrl": url!.absoluteString, "senderId":self.senderId, "senderName":self.senderDisplayName, "MediaType":"PHOTO"] as [String : Any]
                    newMessage.setValue(messageData)
                })
            }
        } else if let video = video {
            let filePath = "\(Date.timeIntervalSinceReferenceDate)"
            let data = try! Data(contentsOf: video)
            let metadata = StorageMetadata()
            metadata.contentType = "video/mp4"
            Storage.storage().reference().child(senderId).child(filePath).putData(data, metadata: metadata) { (meta, err) in
                if err != nil {
                    print(err!.localizedDescription)
                    return
                }
                
                Storage.storage().reference().child(self.senderId).child(filePath).downloadURL(completion: { (url, err) in
                    if err != nil {
                        print(err!.localizedDescription)
                        return
                    }
                    
                    let newMessage = self.messageRef.childByAutoId()
                    let messageData = ["fileUrl": url!.absoluteString, "senderId":self.senderId, "senderName":self.senderDisplayName, "MediaType":"VIDEO"] as [String : Any]
                    newMessage.setValue(messageData)
                })
            }
        }
    }
}

extension ChattingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didPicker")
        
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            sendMedia(picture: picture, video: nil)
        } else if let video = info[UIImagePickerControllerMediaURL] as? URL {
            sendMedia(picture: nil, video: video)
        }
        
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
