//
//  AlunoDAO.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 26/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import CoreData

class AlunoDAO: NSObject {
    
    var contexto: NSManagedObjectContext {
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               return appDelegate.persistentContainer.viewContext
           }
    
    
    func salvaAluno(dicionarioDeAluno: Dictionary<String, Any>) {
               
       let aluno = Aluno(context: contexto)
       
       let caminhoDoDSistemaDeArquivos = NSHomeDirectory() as NSString
       let diretorioDeImagens = "Documents/Images"
       let caminhoCompleto = caminhoDoDSistemaDeArquivos.appendingPathComponent(diretorioDeImagens)
               
       let gerenciadoDeArquivos = FileManager.default
       
       if !gerenciadoDeArquivos.fileExists(atPath: caminhoCompleto){
           do {
               try gerenciadoDeArquivos.createDirectory(atPath: caminhoCompleto, withIntermediateDirectories: false, attributes: nil)
           } catch {
               print(error.localizedDescription)
           }
       }
       
       let nomeDaImagem = String(format: "%@.jpeg", NSUUID().uuidString)
       let url = URL(fileURLWithPath: String(format: "%@/%@", caminhoCompleto, nomeDaImagem))
       
//       guard let imagem = imageAluno.image else { return }
//       guard let data = UIImagePNGRepresentation(imagem) else { return }
       
//       do {
//           try data.write(to: url)
//       }catch {
//           print(error.localizedDescription)
//       }
       
       aluno.nome = dicionarioDeAluno["nome"] as? String
       aluno.endereco = dicionarioDeAluno["endereco"] as? String
       aluno.telefone = dicionarioDeAluno["telefone"] as? String
       aluno.site = dicionarioDeAluno["site"] as? String
       aluno.foto = String(format: "%@/%@", diretorioDeImagens, nomeDaImagem)
        
        
        guard let nota = dicionarioDeAluno["nota"] else { return }
        
        if (nota is String){
           aluno.nota = (dicionarioDeAluno["nota"] as! NSString).doubleValue
        } else {
            let conversaoDeNota = String(describing: nota)
            aluno.nota = (conversaoDeNota as NSString).doubleValue
        }
     
       atualizaContexto()
        
    }
    
    func atualizaContexto(){
        do {
            try contexto.save()            
        } catch {
            print(error.localizedDescription)
        }
    }

}
