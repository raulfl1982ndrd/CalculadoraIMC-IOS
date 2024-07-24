//
//  ViewController.swift
//  CalculadoraIMC-IOS
//
//  Created by Mañanas on 22/7/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    @IBOutlet weak var descripcionLabel: UILabel!
    
    @IBOutlet weak var IMCLabel: UILabel!
    
    @IBOutlet weak var heightStepper: UIStepper!
    @IBOutlet weak var weightSlidder: UISlider!
    
    var height:Int = 160
    var weight:Float = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        heightStepper.value = Double(height)
        weightSlidder.value = weight
        
        onHeightChange(heightStepper)
        onWeightChanged(weightSlidder)
        
    }
    
    @IBAction func onHeightChange(_ sender: UIStepper) {
        height = Int(sender.value)
        heightLabel.text = "\(height) cm"
    }
    @IBAction func onWeightChanged(_ sender: UISlider) {
        weight = sender.value
        //        weightLabel.text = "\(String(format: "%.2f",weight)) Kg"
        let formatedWeight = String(format: "%.2f",weight)
        weightLabel.text = "\(formatedWeight) Kg"

    }
    @IBAction func calculate(_ sender: Any) {
        print("Altura: ", height)
        print("Peso:", weight)
        //calculo el IMC
        let imc = Double(weight) / pow((Double(height) / 100.00),2)
        let formatedIMC = String(format: "%.2f",imc)
        //Calculo Color y Descripcion
        var descripcion: String = "IMC"
        
        var descriptionColor: UIColor
        
        switch imc {
        case 0..<16.5:
            descripcion = "Bajo peso severo"
            print("Bajo peso severo")
            descriptionColor = UIColor(named:"under_weight")!
            
        case 16.5..<18.5:
            descripcion = "Bajo peso"
            print("Bajo peso")
            descriptionColor = UIColor(named:"under_weight")!
        case 18.5..<25:
            descripcion = "Peso normal"
            print("Peso normal")
            descriptionColor = UIColor(named:"normal_weight")!
        case 25..<30:
                descripcion = "Sobrepeso"
            print("Sobrepeso")
            descriptionColor = UIColor(named:"over_weight")!
        case 30..<35:
            descripcion = "Obesidad tipo 1 (moderada)"
            print("Obesidad tipo 1 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        case 35..<40:
            descripcion = "Obesidad tipo 2 (severa)"
            print("Obesidad tipo 2 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        case 40...:
            descripcion = "Obesidad tipo 3 (mórbida)"
            print("Obesidad tipo 3 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        default:
            descripcion = ""
            descriptionColor = UIColor(named:"normal_weight")!
            print("Have you done something new?")
        }
        
        //Muestro el resultado
        IMCLabel.text = formatedIMC
        descripcionLabel.text = descripcion
        IMCLabel.textColor = descriptionColor
        descripcionLabel.textColor = descriptionColor
    }
}

