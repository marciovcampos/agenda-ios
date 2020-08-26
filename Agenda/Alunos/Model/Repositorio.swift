//
//  Repositorio.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 26/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    
    func salvaAluno(aluno:Dictionary<String, String>){
        AlunoAPI().salvaAlunosNoServidor(parametros: aluno)
        AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
    }

}
