//
//  MapaViewController.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 24/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class MapaViewController: UIViewController {
    
    // MARK: - Variavel
    
    var aluno:Aluno?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        
        print(aluno?.nome)
    }
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }


}
