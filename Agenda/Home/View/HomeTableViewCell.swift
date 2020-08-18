//
//  HomeTableViewCell.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var labelNomeDoAluno: UILabel!
    
    func configuraCelula(_ aluno: Aluno){
        labelNomeDoAluno.text = aluno.nome
        imageAluno.layer.cornerRadius = imageAluno.frame.width / 2
        
        let gerenciadoDeArquivos = FileManager.default

        let caminho = NSHomeDirectory() as NSString
        let caminhoDaImagem = caminho.appendingPathComponent(aluno.foto!)
          
          if gerenciadoDeArquivos.fileExists(atPath: caminhoDaImagem){
              imageAluno.image = UIImage(contentsOfFile: caminhoDaImagem)
          }
 
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
