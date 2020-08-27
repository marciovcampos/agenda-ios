//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 26/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    let urlApi = "https://agenda-ios.herokuapp.com/api/aluno"
    
    // MARK: - GET
    
    func recuperaAlunos(completion:@escaping() -> Void){
        AF.request(urlApi, method: .get).responseJSON { (response) in
            switch response.result {
                case .success:
                    if let resposta = response.value as? Dictionary<String, Any> {
                        guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String, Any>> else { return }
                        
                        for dicionarioDeAluno in listaDeAlunos {
                            AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAluno)
                        }
                        completion()
                    }
                case .failure:
                    print(response.error!)
                    completion()
                    break
                }
        }
    }
    
    // MARK: - POST
    
    func salvaAlunosNoServidor(parametros: Dictionary<String, String>) {
        guard let url = URL(string: urlApi) else { return }
        
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "POST"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
               
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
        let response = AF.request(requisicao)
        
        response.responseJSON { (data) in
          print(data)
        }
                
    }
    
    // MARK: - DELETE
    
    func deletaAluno(id:String){
        
        AF.request("\(urlApi)/\(id)", method: .delete).responseJSON { (resposta) in
            print(resposta.result)
            switch resposta.result {
            case .failure:
                print(resposta.error!)
            default:
                break
            }
        }
        
    }
    

}
