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
    
    var gerenciadorDeResultados:NSFetchedResultsController<Aluno>?
    var contexto: NSManagedObjectContext {
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               return appDelegate.persistentContainer.viewContext
           }
    
    func recuperaAlunos() -> Array<Aluno> {
              
        let pesquisaAluno:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenaPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaPorNome]
     
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try gerenciadorDeResultados?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else { return [] }
        
        return listaDeAlunos
        
    }
    
    func salvaAluno(dicionarioDeAluno: Dictionary<String, Any>) {
        
        
      // Salva imagem
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
               
               
        var aluno:NSManagedObject?
        guard let id = UUID(uuidString: dicionarioDeAluno["id"] as! String) else { return }
        
        let alunos = recuperaAlunos().filter() { $0.id == id}
        
        if alunos.count > 0 {
            guard let alunoEncontrado = alunos.first else { return }
            aluno = alunoEncontrado
        } else {
            let entidade = NSEntityDescription.entity(forEntityName: "Aluno", in: contexto)
            aluno = NSManagedObject(entity: entidade!, insertInto: contexto)
        }
      
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(dicionarioDeAluno["nome"] as? String, forKey: "nome")
        aluno?.setValue(dicionarioDeAluno["endereco"] as? String, forKey: "endereco")
        aluno?.setValue(dicionarioDeAluno["telefone"] as? String, forKey: "telefone")
        aluno?.setValue(dicionarioDeAluno["site"] as? String, forKey: "site")
        aluno?.setValue(String(format: "%@/%@", diretorioDeImagens, nomeDaImagem), forKey: "foto")
                     
        guard let nota = dicionarioDeAluno["nota"] else { return }
        
        if (nota is String){
           aluno?.setValue((dicionarioDeAluno["nota"] as! NSString).doubleValue, forKey: "nota")
        } else {
            let conversaoDeNota = String(describing: nota)
            aluno?.setValue((conversaoDeNota as NSString).doubleValue, forKey: "nota")
        }

       atualizaContexto()
        
    }
    
    func deletaAluno(aluno: Aluno){
        contexto.delete(aluno)
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
