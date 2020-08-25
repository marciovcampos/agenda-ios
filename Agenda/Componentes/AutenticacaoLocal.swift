//
//  AutenticacaoLocal.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 25/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    
    var error:NSError?
    
    func autorizaUsuario(completion:@escaping(_ autenticado:Bool) -> Void) {
        let contexto = LAContext()
        if contexto.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            contexto.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "É necessário autenticação para apagar um aluno", reply: {
                (resposta, erro) in
                completion(resposta)
            })
        }
        
    }

}
