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
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var IMCLabel: UILabel!
    
    @IBOutlet weak var heightStepper: UIStepper!
    @IBOutlet weak var weightSlidder: UISlider!
    
    static let obesityAdvice = "https://www.teknon.es/es/especialidades/gonzalbez-morgaez-jose/dietetica-obesidad/recomendaciones-pacientes-obesidad"

    
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
        var showAlert:Bool = false
        //calculo el IMC
        let imc = Double(weight) / pow((Double(height) / 100.00),2)
        let formatedIMC = String(format: "%.2f",imc)
        //Calculo Color y Descripcion
        var descripcion: String = "IMC"
        var estado: String = ""
        var descriptionColor: UIColor
        
        switch imc {
        case 0..<16.5:
            showAlert = false
            descripcion = "Bajo peso severo"
            estado = "Aumente su peso"
            print("Bajo peso severo")
            descriptionColor = UIColor(named:"under_weight")!
            
        case 16.5..<18.5:
            showAlert = false
            descripcion = "Bajo peso"
            estado = "Aumente su peso"
            print("Bajo peso")
            descriptionColor = UIColor(named:"under_weight")!
        case 18.5..<25:
            descripcion = "Peso normal"
            estado = "Peso correcto"
            print("Peso normal")
            descriptionColor = UIColor(named:"normal_weight")!
        case 25..<30:
            showAlert = false
                descripcion = "Sobrepeso"
            estado = "Aumente su peso"
            print("Reduzca su peso")
            descriptionColor = UIColor(named:"over_weight")!
        case 30..<35:
            showAlert = true
            descripcion = "Obesidad tipo 1 (moderada)"
            estado = "Consulte con su medico"
            print("Obesidad tipo 1 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        case 35..<40:
            showAlert = true
            descripcion = "Obesidad tipo 2 (severa)"
            estado = "Consulte con su medico"
            print("Obesidad tipo 2 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        case 40...:
            showAlert = true
            descripcion = "Obesidad tipo 3 (mórbida)"
            estado = "Consulte con su medico"
            print("Obesidad tipo 3 (moderada)")
            descriptionColor = UIColor(named:"obesity_weight")!
        default:
            descripcion = "Fuera de Rango"
            estado = "Fuera de Ranngo"
            descriptionColor = UIColor(named:"normal_weight")!
            print("Have you done something new?")
        }
        if (showAlert){
            showObesityAlert()
        }
        //Muestro el resultado
        IMCLabel.text = formatedIMC
        descripcionLabel.text = descripcion
        estadoLabel.text = estado
        estadoLabel.textColor = descriptionColor
        IMCLabel.textColor = descriptionColor
        descripcionLabel.textColor = descriptionColor
    }
    
    func showObesityAlert(){
        let alert = UIAlertController(
            title: "Alerta Sanitaria",
            message: "Deberias cuidar tu salud, asiste al medico para estudiar tu caso", preferredStyle:UIAlertController.Style.alert
            )
        
        alert.addAction(UIAlertAction(
            title: "Me la suda",
            style: UIAlertAction.Style.destructive,
            handler:nil)
            ) 
        alert.addAction(UIAlertAction(
            title: "Recomendaciones",
            style: UIAlertAction.Style.cancel,
            handler:{action in
                if let url = URL (string :HomeViewController.obesityAdvice), UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            })
            )
        alert.view.tintColor = UIColor.systemOrange
        
        self.present(alert,animated:true,completion:nil)
        
    }
    
}

