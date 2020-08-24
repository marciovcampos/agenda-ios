//
//  MapaViewController.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 24/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class MapaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
    }
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }


}
