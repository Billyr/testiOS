//
//  Velocimetro - Guillermo Rangel
//

import UIKit

// Enumeración
enum Velocidades : Int {
    case
    Apagado = 0,
    VelocidadBaja = 20,
    VelocidadMedia = 50,
    VelocidadAlta = 120
    
    init(velocidadInicial : Velocidades) {
        self = velocidadInicial
    }
}

// Calse
class Auto {
    
    var velocidad:Velocidades
    
    init() {
        
        self.velocidad = .Apagado
        self.velocidad = Velocidades(velocidadInicial: velocidad)
    }
    
    
    
    func cambioDeVelocidad() -> (actual : Int, velocidadEnCadena: String)? {
        
        
        let velocidadNumero = velocidad.rawValue
        
        switch velocidadNumero {
        case 0:
            velocidad = .VelocidadBaja
            return (velocidadNumero, "Apagado")
        case 20:
            velocidad = .VelocidadMedia
            return (velocidadNumero, "Velocidad Baja")
        case 50:
            velocidad = .VelocidadAlta
            return (velocidadNumero, "Velocidad Media")
        case 120:
            velocidad = .VelocidadMedia
            return (velocidadNumero, "Velocidad Alta")
        default:
            return nil
        }
        
        
    }
    
}

// Prueba de Clase

var auto = Auto()

for i in 1...20 {
    
    let valores = auto.cambioDeVelocidad()
    print( "\(valores!.0) \(valores!.1)" )
}

