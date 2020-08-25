//
//  Pino.swift
//  Agenda
//
//  Created by Marcio Vinicius Campos da Silveira on 25/08/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class Pino: NSObject, MKAnnotation {
    
    var title: String?
    var icon: UIImage?
    var color: UIColor?
    var coordinate: CLLocationCoordinate2D
    
    init(coordenada: CLLocationCoordinate2D) {
        self.coordinate = coordenada
    }

}
