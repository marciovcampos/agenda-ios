//
//  ImagePicker.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 11/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

protocol ImagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto:UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate {
    
    // MARK: - Atributos

    var delegate:ImagePickerFotoSelecionada?

    // MARK: - Métodos

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
    }

}
