//
//  ProfileImageCell.swift
//  AirbnbProject
//
//  Created by 김승진 on 2018. 8. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit

protocol ProfileImageCellDelegate: class {
    func presentViewController(viewController: UIViewController)
    func profileImageDelivery(profileImage: UIImage)
}

class ProfileImageCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    weak var delegate: ProfileImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

    @IBAction func imagePickerAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let takePhoto = UIAlertAction(title: "사진촬영", style: UIAlertActionStyle.default) { (_) in
            
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            picker.allowsEditing = true
            
            self.delegate?.presentViewController(viewController: picker)
        }
        
        let importAlbum = UIAlertAction(title: "사진 선택", style: UIAlertActionStyle.default) { (_) in
            
            guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return }
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            
            self.delegate?.presentViewController(viewController: picker)
        }
        
        alertController.addAction(takePhoto)
        alertController.addAction(importAlbum)
        
        delegate?.presentViewController(viewController: alertController)
    }

}

extension ProfileImageCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        let selectedImage = originalImage ?? editedImage
        
        self.profileImageView.image = selectedImage
        
        delegate?.profileImageDelivery(profileImage: selectedImage!)
        
        UIImageWriteToSavedPhotosAlbum(selectedImage!, nil, nil, nil)
        picker.dismiss(animated: true, completion: nil)
        
    }
}
