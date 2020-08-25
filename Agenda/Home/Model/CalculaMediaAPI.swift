//
//  CalculaMediaAPI.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 25/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class CalculaMediaAPI: NSObject {
    
    func calculaMediaGeralDosAlunos(){
        
        guard let url = URL(string: "https://www.caelum.com.br/mobile") else { return }
        var listaDeAlunos:Array<Dictionary<String, Any>> = []
        var json:Dictionary<String, Any> = [:]
        
        let dicionarioDeAlunos = [
            "id":"1",
            "nome":"João da Silva",
            "endereco":"Masp, São Paulo",
            "telefone":"(31) 99999-9999",
            "site":"www.alura.com.br",
            "nota":"8"
        ]
        listaDeAlunos.append(dicionarioDeAlunos as [String:Any])
        json = [
            "list" : [
                "aluno" : listaDeAlunos
            ]
        ]
        
        do {
            var requisicao = URLRequest(url: url)
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            requisicao.httpBody = data
            requisicao.httpMethod = "POST"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: requisicao, completionHandler: { (data, response, error) in
                if error == nil {
                    do {
                        let dicionario = try JSONSerialization.jsonObject(with: data!, options:[])
                        print(dicionario)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
       
    }

}
