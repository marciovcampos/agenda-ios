//
//  MapaViewController.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 24/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapa: MKMapView!
    
    // MARK: - Variavel
    
    var aluno:Aluno?
    lazy var localizacao = Localizacao()
        
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
    }
    
    // MARK: Métodos
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    
    func localizacaoInicial(){
        Localizacao().converterEnderecoEmCoordenadas(endereco: "Caelum - São Paulo") { (localizacaoEncontrada) in
            let pino = Localizacao().configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada, cor: .black, icone: UIImage(named: "icon_caelum"))
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 500, 500)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno {
            Localizacao().converterEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icone: nil)
            self.mapa.addAnnotation(pino)
            }
            
        }
    }
    
    
    


}
