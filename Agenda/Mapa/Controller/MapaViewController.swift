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
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
    }
    
    // MARK: Métodos
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    
    func localizacaoInicial(){
        Localizacao().converterEnderecoEmCoordenadas(endereco: "Trianon - Masp") { (localizacaoEncontrada) in
            let pino = self.configuraPino(titulo: "Trianon - Masp", localizacao: localizacaoEncontrada)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 500, 500)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno(){
        if let aluno = aluno {
            Localizacao().converterEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
                let pino = self.configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
            self.mapa.addAnnotation(pino)
            }
            
        }
    }
    
    func configuraPino(titulo:String, localizacao:CLPlacemark) -> MKPointAnnotation {
        let pino = MKPointAnnotation()
        pino.title = titulo
        pino.coordinate = localizacao.location!.coordinate
        return pino
    }
    
    


}
